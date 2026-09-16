//
//  UIView+Initializers.swift
//  Created by Devin Ross on 4/17/15.
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


extension UIView {
	
	/** A view with the given frame. */
	@objc(viewWithFrame:)
	public static func view(frame: CGRect) -> Self {
		self.init(frame: frame)
	}
	
	/** A view with the given frame and background color. */
	@objc(viewWithFrame:backgroundColor:)
	public static func view(frame: CGRect, backgroundColor: UIColor) -> Self {
		let view = self.init(frame: frame)
		view.backgroundColor = backgroundColor
		return view
	}
	
	/** A view with the given frame, background color and corner radius. */
	@objc(viewWithFrame:backgroundColor:cornerRadius:)
	public static func view(frame: CGRect, backgroundColor: UIColor, cornerRadius: CGFloat) -> Self {
		let view = self.view(frame: frame, backgroundColor: backgroundColor)
		view.cornerRadius = cornerRadius
		return view
	}
	
	/** A view with the given frame, background color, corner radius and border. */
	@objc(viewWithFrame:backgroundColor:cornerRadius:borderColor:borderWidth:)
	public static func view(frame: CGRect, backgroundColor: UIColor, cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) -> Self {
		let view = self.view(frame: frame, backgroundColor: backgroundColor, cornerRadius: cornerRadius)
		view.setBorder(color: borderColor, width: borderWidth)
		return view
	}
	
	/** Creates a view with the given frame and background color. */
	@objc(initWithFrame:backgroundColor:)
	public convenience init(frame: CGRect, backgroundColor: UIColor) {
		self.init(frame: frame)
		self.backgroundColor = backgroundColor
	}
	
	/** Creates a view with the given frame, background color and corner radius. */
	@objc(initWithFrame:backgroundColor:cornerRadius:)
	public convenience init(frame: CGRect, backgroundColor: UIColor, cornerRadius: CGFloat) {
		self.init(frame: frame, backgroundColor: backgroundColor)
		self.cornerRadius = cornerRadius
	}
	
	/** Creates a view with the given frame, background color, corner radius and border. */
	@objc(initWithFrame:backgroundColor:cornerRadius:borderColor:borderWidth:)
	public convenience init(frame: CGRect, backgroundColor: UIColor, cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
		self.init(frame: frame, backgroundColor: backgroundColor, cornerRadius: cornerRadius)
		setBorder(color: borderColor, width: borderWidth)
	}
	
}
