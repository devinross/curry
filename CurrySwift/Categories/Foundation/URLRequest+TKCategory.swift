//
//  URLRequest+TKCategory.swift
//  Created by Devin Ross on 10/30/18.
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


extension URLRequest {
	
	/** Returns a cURL command representation of this URL request. */
	public var curlString: String {
		
		var command = "curl -v -X \(httpMethod ?? "GET")"
		
		if let url {
			command += " '\(url.absoluteString)'"
		}
		
		for (key, value) in allHTTPHeaderFields ?? [:] {
			command += " -H '\(key): \(value)'"
		}
		
		if let method = httpMethod, ["POST", "PUT", "PATCH"].contains(method),
		   let data = httpBody, let body = String(data: data, encoding: .utf8) {
			command += " -d '\(body)'"
		}
		
		return command
	}
	
}


extension NSURLRequest {
	
	/** Returns a cURL command representation of this URL request. */
	@objc public var curlString: String {
		(self as URLRequest).curlString
	}
	
}
