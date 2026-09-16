//
//  NSArray+TKCategory.swift
//  Created by Devin Ross on 11/9/10.
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


/** Additional functionality for `NSArray`. */
extension NSArray {
	
	/** Returns a random object in the array.
	@return A randomly chosen object, or nil if the array is empty.
	*/
	@objc public var randomObject: Any? {
		guard count > 0 else { return nil }
		return object(at: Int.random(in: 0 ..< count))
	}
	
}


/** Additional functionality for `NSMutableArray`. */
extension NSMutableArray {
	
	/** Shuffles the order of the objects. */
	@objc public func shuffle() {
		let total = count
		guard total > 1 else { return }
		for i in 0 ..< total {
			let n = Int.random(in: i ..< total)
			if i != n { exchangeObject(at: i, withObjectAt: n) }
		}
	}
	
	/** Remove first object.
	
	Raises an `NSRangeException` when the array is empty, matching
	`removeObjectAtIndex:`.
	*/
	@objc public func removeFirstObject() {
		removeObject(at: 0)
	}
	
}
