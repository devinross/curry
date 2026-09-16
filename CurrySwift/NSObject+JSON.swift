//
//  NSObject+JSON.swift
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


public typealias TKJSONCompletionBlock = (Any?, Error?) -> Void
public typealias TKJSONNetworkCompletionBlock = (Any?, URLResponse?, Error?) -> Void


/// Run `work` on the main queue, executing it inline when already there.
///
/// The Objective-C original used `dispatch_sync(dispatch_get_main_queue(), ...)`
/// unconditionally, which deadlocks whenever the caller is already on the main
/// queue. This keeps the synchronous hand-off without that hazard.
private func onMain(_ work: @escaping () -> Void) {
	if Thread.isMainThread {
		work()
	} else {
		DispatchQueue.main.sync(execute: work)
	}
}


/** Additional functionality for `NSObject` that makes it easy to turn `Data` into JSON on a background thread. */
extension NSObject {
	
	/** Process JSON data in the background with a completion block.
	@param data The JSON data.
	@param block The block that will be performed upon the parsing of the json data.
	*/
	@objc(processJSON:withCompletion:)
	open func processJSON(_ data: Data, withCompletion block: TKJSONCompletionBlock?) {
		processJSON(data, options: [], withCompletion: block)
	}
	
	/** Process JSON data in the background with a completion block.
	@param data The JSON data.
	@param options JSON parsing options used while parsing the JSON data.
	@param block The block that will be performed upon the parsing of the json data.
	*/
	@objc(processJSON:options:withCompletion:)
	open func processJSON(_ data: Data, options: JSONSerialization.ReadingOptions, withCompletion block: TKJSONCompletionBlock?) {
		DispatchQueue.global(qos: .default).async {
			var object: Any?
			var parseError: Error?
			do {
				object = try JSONSerialization.jsonObject(with: data, options: options)
			} catch {
				parseError = error
			}
			onMain { block?(object, parseError) }
		}
	}
	
	/** Process the JSON body of a network response in the background with a completion block.
	@param data The JSON data.
	@param response The response that accompanied the data.
	@param error An error produced by the request, which short-circuits parsing.
	@param options JSON parsing options used while parsing the JSON data.
	@param block The block that will be performed upon the parsing of the json data.
	*/
	@objc(processJSON:response:error:options:withCompletion:)
	open func processJSON(_ data: Data?, response: URLResponse?, error: Error?, options: JSONSerialization.ReadingOptions, withCompletion block: TKJSONNetworkCompletionBlock?) {
		
		if let error {
			onMain { block?(nil, response, error) }
			return
		}
		
		guard let data else {
			onMain { block?(nil, response, nil) }
			return
		}
		
		DispatchQueue.global(qos: .default).async {
			var object: Any?
			var parseError: Error?
			do {
				object = try JSONSerialization.jsonObject(with: data, options: options)
			} catch {
				parseError = error
			}
			onMain { block?(object, response, parseError) }
		}
	}
	
}
