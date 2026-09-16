//
//  UIButton+TKCategory.swift
//  Created by Devin Ross on 1/9/11.
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


/** Additional functionality for `UIButton`. */
extension UIButton {
	
	/** A button with the given frame. */
	@objc(buttonWithFrame:)
	public static func button(frame: CGRect) -> Self {
		self.init(frame: frame)
	}
	
	/** A custom button with the given frame and title. */
	@objc(buttonWithFrame:title:)
	public static func button(frame: CGRect, title: String) -> Self {
		let button = custom(frame: frame)
		button.setTitle(title, for: .normal)
		return button
	}
	
	/** A custom button with the given frame, title and background image. */
	@objc(buttonWithFrame:title:backgroundImage:)
	public static func button(frame: CGRect, title: String, backgroundImage: UIImage) -> Self {
		let button = self.button(frame: frame, title: title)
		button.setBackgroundImage(backgroundImage, for: .normal)
		return button
	}
	
	/** A custom button with the given frame, title and background images. */
	@objc(buttonWithFrame:title:backgroundImage:highlightedBackgroundImage:)
	public static func button(frame: CGRect, title: String, backgroundImage: UIImage, highlightedBackgroundImage: UIImage) -> Self {
		let button = self.button(frame: frame, title: title, backgroundImage: backgroundImage)
		button.setBackgroundImage(highlightedBackgroundImage, for: .highlighted)
		return button
	}
	
	/** A custom button with the given frame and image. */
	@objc(buttonWithFrame:image:)
	public static func button(frame: CGRect, image: UIImage) -> Self {
		let button = custom(frame: frame)
		button.setImage(image, for: .normal)
		return button
	}
	
	/** A custom button with the given frame and images. */
	@objc(buttonWithFrame:image:highlightedImage:)
	public static func button(frame: CGRect, image: UIImage, highlightedImage: UIImage) -> Self {
		let button = self.button(frame: frame, image: image)
		button.setImage(highlightedImage, for: .highlighted)
		return button
	}
	
	private static func custom(frame: CGRect) -> Self {
		let button = self.init(type: .custom)
		button.frame = frame
		return button
	}
	
}
