//
//  NSArrayTests.swift
//  Created by Devin on 7/18/12.
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

import XCTest
import curry


final class NSArrayTests: XCTestCase {
	
	func testShouldReturnFirstObject() {
		
		XCTAssertNil(([] as NSArray).firstObject)
		
		let array: NSArray = ["BOB"]
		XCTAssertEqual(array.firstObject as? String, "BOB")
		XCTAssertEqual(array.firstObject as? String, array[0] as? String)
	}
	
	func testShouldReturnRandomObjects() {
		
		let array = NSMutableArray(capacity: 5000)
		for i in 0 ..< 5000 { array.add(NSNumber(value: i)) }
		
		var lastNumber = array.randomObject as? NSNumber
		var equal = 0, different = 0
		
		for _ in 0 ..< 500 {
			let number = array.randomObject as? NSNumber
			if number == lastNumber { equal += 1 } else { different += 1 }
			lastNumber = number
		}
		
		XCTAssertTrue(different > equal)
	}
	
}
