//
//  URLSession+TKCategory.swift
//  Created by Devin Ross on 4/10/15.
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


/// `NSJSONSerialization` reports a malformed payload with this code.
private let jsonCorruptErrorCode = 3840


/** Additional functionality for `URLSession` for getting json data. */
extension URLSession {
	
	/** Create a data task that decodes its response body as JSON.
	@param request The `URLRequest` of the request.
	@param options JSON reading options.
	@param completion The block that is called upon completion.
	@return The `URLSessionDataTask` object.
	*/
	@objc(jsonDataTaskWithRequest:options:completionHandler:)
	public func jsonDataTask(with request: URLRequest,
	                         options: JSONSerialization.ReadingOptions,
	                         completionHandler completion: (@Sendable (Any?, URLResponse?, Error?) -> Void)?) -> URLSessionDataTask {
		dataTask(with: request) { [weak self] data, response, error in
			self?.finishJSONTask(data: data, response: response, error: error, options: options, completion: completion)
		}
	}
	
	/** Create a data task that decodes its response body as JSON.
	@param url The `URL` of the request.
	@param options JSON reading options.
	@param completion The block that is called upon completion.
	@return The `URLSessionDataTask` object.
	*/
	@objc(jsonDataTaskWithURL:options:completionHandler:)
	public func jsonDataTask(with url: URL,
	                         options: JSONSerialization.ReadingOptions,
	                         completionHandler completion: (@Sendable (Any?, URLResponse?, Error?) -> Void)?) -> URLSessionDataTask {
		dataTask(with: url) { [weak self] data, response, error in
			self?.finishJSONTask(data: data, response: response, error: error, options: options, completion: completion)
		}
	}
	
	private func finishJSONTask(data: Data?,
	                            response: URLResponse?,
	                            error: Error?,
	                            options: JSONSerialization.ReadingOptions,
	                            completion: (@Sendable (Any?, URLResponse?, Error?) -> Void)?) {
		
		guard let data, !data.isEmpty else {
			DispatchQueue.main.async { completion?(nil, response, error) }
			return
		}
		
		processJSON(data, response: response, error: error, options: options) { object, response, jsonError in
			guard let completion else { return }
			
			// A body that is not JSON at all is still worth handing back as text.
			if (jsonError as? NSError)?.code == jsonCorruptErrorCode {
				let text = String(data: data, encoding: .utf8)
				let fallback: Any? = object ?? text.map { $0 as Any }
				completion(fallback, response, error ?? jsonError)
			} else {
				completion(object, response, error ?? jsonError)
			}
		}
	}
	
}
