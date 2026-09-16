//
//  UIScrollView+Positioning.swift
//  Created by Devin Ross on 7/1/15.
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


extension UIScrollView {
	
	/** The width of the content size. */
	@objc public var contentWidth: CGFloat {
		get { contentSize.width }
		set { contentSize = CGSize(width: newValue, height: contentSize.height) }
	}
	
	/** The height of the content size. */
	@objc public var contentHeight: CGFloat {
		get { contentSize.height }
		set { contentSize = CGSize(width: contentSize.width, height: newValue) }
	}
	
	/** The horizontal content offset. */
	@objc public var contentXOffset: CGFloat {
		get { contentOffset.x }
		set { contentOffset = CGPoint(x: newValue, y: contentOffset.y) }
	}
	
	/** The vertical content offset. */
	@objc public var contentYOffset: CGFloat {
		get { contentOffset.y }
		set { contentOffset = CGPoint(x: contentOffset.x, y: newValue) }
	}
	
}
