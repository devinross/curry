//
//  UINavigationBar+TKCategory.swift
//  Created by Devin Ross on 3/4/14.
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


/** Additional functionality for `UINavigationBar`. */
extension UINavigationBar {
	
	/** The hairline image view drawn under the bar, if the bar still has one. */
	@objc public var hairlineDividerView: UIView? {
		UINavigationBar.hairlineImageView(under: self)
	}
	
	/// The first image view in the tree that is no taller than a single pixel.
	private static func hairlineImageView(under view: UIView) -> UIImageView? {
		
		let onePixel = 1.0 / UIScreen.main.scale
		if let imageView = view as? UIImageView, view.bounds.height - onePixel < 1.0 {
			return imageView
		}
		
		for subview in view.subviews {
			if let found = hairlineImageView(under: subview) { return found }
		}
		
		return nil
	}
	
}
