//  Converted to Swift 5.3 by Swiftify v5.3.29144 - https://swiftify.com/
//
//  NSObject+JSON.m
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


public typealias TKJSONCompletionBlock = (Any?, Error?) -> Void
public typealias TKJSONNetworkCompletionBlock = (Any?, URLResponse?, Error?) -> Void

/// Additional functionality for `NSObject` that make it easy to turn `NSData` to json data on a background thread.
extension NSObject {
	
// MARK: Process JSON in Background
	/// Process JSON data in the background with a completion block.
	/// - Parameters:
	///   - data: The JSON data.
	///   - block: The block that will be performed upon the parsing of the json data. The process data will be included as an object with the selector.
	@objc public func processJSON(_ data: Data?, withCompletion block: @escaping TKJSONCompletionBlock) {
		processJSON(data, options: .allowFragments, withCompletion: block)
    }

	/// Process JSON data in the background with a completion block.
	/// - Parameters:
	///   - data: The JSON data.
	///   - options: An json parsing options to be included will parsing the JSON data.
	///   - block: The block that will be performed upon the parsing of the json data. The process data will be included as an object with the selector.
	@objc public func processJSON(_ data: Data?, response: URLResponse?, error: Error?, options: JSONSerialization.ReadingOptions, withCompletion block: @escaping TKJSONNetworkCompletionBlock) {

        if let error = error {
            DispatchQueue.main.sync(execute: {
				block(nil, response, error)
            })
            return
        }


        let queue = DispatchQueue.global(qos: .default)
		
        queue.async(execute: {

            var err: Error?
            var object: Any? = nil
            do {
                if let data = data {
                    object = try JSONSerialization.jsonObject(with: data, options: options)
                }
            } catch let err {
            }
            DispatchQueue.main.sync(execute: {
				block(object, response, err)
            })
        })

    }

	@objc public func processJSON(_ data: Data?, options: JSONSerialization.ReadingOptions, withCompletion block: @escaping TKJSONCompletionBlock) {

        let queue = DispatchQueue.global(qos: .default)
		queue.async {
			var error: Error?
			var object: Any? = nil
			do {
				if let data = data {
					object = try JSONSerialization.jsonObject(with: data, options: options)
				}
			} catch {
			}
			DispatchQueue.main.sync(execute: {
				block(object, error)
			})
		}


    }
}
