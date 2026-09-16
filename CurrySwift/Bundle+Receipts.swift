//
//  Bundle+Receipts.swift
//  Created by Devin Ross on 10/25/16.
//
/*

curry || https://github.com/devinross/curry

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

*/

import Foundation
import StoreKit


extension Bundle {
	
	private static let productionVerifyURL = URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
	private static let sandboxVerifyURL = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
	
	/// Status code Apple returns when a production receipt was actually issued by the sandbox.
	private static let sandboxReceiptStatus = 21007
	
	/** Send the app's receipt to the App Store for verification.
	
	- Note: This validates the receipt directly from the device, which Apple
	  advises against because the device-to-App-Store connection can be spoofed.
	  Verifying on your own server remains the recommended approach.
	
	@param completion Called with the decoded receipt, the response and any error.
	*/
	@objc(requestReceiptOnAppStore:)
	public func requestReceiptOnAppStore(_ completion: @escaping @Sendable (Any?, URLResponse?, Error?) -> Void) {
		
		guard let receiptURL = Bundle.main.appStoreReceiptURL,
		      let receiptData = try? Data(contentsOf: receiptURL) else {
			completion(nil, nil, nil)
			return
		}
		
		requestReceipt(url: Bundle.productionVerifyURL, receiptData: receiptData) { object, response, error in
			
			// A production receipt that came from the sandbox has to be retried there.
			if let payload = object as? [String: Any],
			   (payload["status"] as? NSNumber)?.intValue == Bundle.sandboxReceiptStatus {
				self.requestReceipt(url: Bundle.sandboxVerifyURL, receiptData: receiptData, completion: completion)
				return
			}
			
			completion(object, response, error)
		}
	}
	
	private func requestReceipt(url: URL, receiptData: Data, completion: @escaping @Sendable (Any?, URLResponse?, Error?) -> Void) {
		
		let encoded = receiptData.base64EncodedString()
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		do {
			request.httpBody = try JSONSerialization.data(withJSONObject: ["receipt-data": encoded])
		} catch {
			completion(nil, nil, error)
			return
		}
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let error {
				DispatchQueue.main.async { completion(nil, response, error) }
				return
			}
			
			guard let data, !data.isEmpty else {
				DispatchQueue.main.async { completion(nil, response, nil) }
				return
			}
			
			var object: Any?
			var parseError: Error?
			do {
				object = try JSONSerialization.jsonObject(with: data)
			} catch {
				parseError = error
			}
			
			DispatchQueue.main.async { completion(object, response, parseError) }
			
		}.resume()
	}
	
}
