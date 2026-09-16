//
//  UILabel+TKCategory.swift
//  Created by Devin Ross on 10/7/14.
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

import UIKit


/** Additional functionality for `UILabel`. */
extension UILabel {
	
	/** Sizes the label to fit its text, keeping the text where its alignment put it. */
	@objc open func sizeToFitWithAlignment() {
		
		guard textAlignment == .center || textAlignment == .right else {
			sizeToFit()
			return
		}
		
		let original = frame
		sizeToFit()
		
		var resized = frame
		var xPad = Int(original.width - resized.width)
		if textAlignment == .center { xPad /= 2 }
		
		resized.origin.x = original.minX + CGFloat(xPad)
		frame = resized
	}
	
	/** Sizes the label to fit its text, keeping it aligned and vertically centered. */
	@objc open func sizeToFitWithAlignmentAndVerticalCentering() {
		
		let original = frame
		sizeToFitWithAlignment()
		
		var resized = frame
		let yPad = Int(original.height - resized.height) / 2
		resized.origin.y = original.minY + CGFloat(yPad)
		frame = resized
	}
	
	/** Sizes the label's height to fit its text, leaving the width alone. */
	@objc open func sizeToFitHeight() {
		let width = frame.width
		sizeToFit()
		frame.size.width = width
	}
	
}
