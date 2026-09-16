//
//  UIScrollview+TKCategory.swift
//  Created by Devin Ross on 11/17/10.
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


/** Additional functionality for `UIScrollView`. */
extension UIScrollView {
	
	/** Scrolls back to the top of the content, respecting the content inset. */
	@objc public func scrollToTop() {
		contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
	}
	
	/** The horizontal page currently shown, for a paging scroll view. */
	@objc public var currentHorizontalPage: Int {
		let width = frame.width
		guard width > 0 else { return 0 }
		return Int((width / 2 + contentOffset.x) / width)
	}
	
	/** The vertical page currently shown, for a paging scroll view. */
	@objc public var currentVerticalPage: Int {
		let height = frame.height
		guard height > 0 else { return 0 }
		return Int((height / 2 + contentOffset.y) / height)
	}
	
	/** How far the content is scrolled from its end, rather than from its start. */
	@objc public var contentOffsetFromEnd: CGPoint {
		
		let width = frame.width
		let height = frame.height
		
		var x = contentSize.width - contentOffset.x - width
		var y = contentSize.height - contentOffset.y - height
		
		if contentSize.width < width { x = -contentOffset.x }
		if contentSize.height < height { y = -contentOffset.y }
		
		return CGPoint(x: x, y: y)
	}
	
}
