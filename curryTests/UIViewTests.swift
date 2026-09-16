//
//  UIViewTests.swift
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
import UIKit
import curry


final class UIViewTests: XCTestCase {
	
	func testShouldAddSubviewToBack() {
		
		let zero = CGRect.zero
		let superview = UIView(frame: zero)
		let one = UIView(frame: zero)
		let two = UIView(frame: zero)
		let three = UIView(frame: zero)
		
		superview.addSubview(one)
		superview.addSubview(two)
		superview.addSubviewToBack(three)
		
		XCTAssertTrue(superview.subviews[0] === three)
	}
	
	func testShouldMakeViewVisible() {
		
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		view.visible = false
		XCTAssertTrue(view.isHidden, "View is visible")
		
		view.visible = true
		XCTAssertFalse(view.isHidden, "View is not visible")
	}
	
}
