//
//  UILabel+Initializers.swift
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


extension UILabel {
	
	/** A label with attributed text, a font, a color and an alignment. */
	@objc(labelWithFrame:attributedText:font:textColor:textAlignment:)
	open class func label(frame: CGRect, attributedText: NSAttributedString?, font: UIFont, textColor: UIColor, textAlignment alignment: NSTextAlignment) -> Self {
		let label = self.init(frame: frame)
		label.textColor = textColor
		label.font = font
		label.attributedText = attributedText
		label.textAlignment = alignment
		return label
	}
	
	/** A label with text, a font, a color and an alignment. */
	@objc(labelWithFrame:text:font:textColor:textAlignment:)
	open class func label(frame: CGRect, text: String?, font: UIFont, textColor: UIColor, textAlignment alignment: NSTextAlignment) -> Self {
		let label = self.label(frame: frame, font: font, textColor: textColor, textAlignment: alignment)
		label.text = text
		return label
	}
	
	/** A label with a font. */
	@objc(labelWithFrame:font:)
	open class func label(frame: CGRect, font: UIFont) -> Self {
		let label = self.init(frame: frame)
		label.font = font
		return label
	}
	
	/** A label with a font and a color. */
	@objc(labelWithFrame:font:textColor:)
	open class func label(frame: CGRect, font: UIFont, textColor: UIColor) -> Self {
		let label = self.label(frame: frame, font: font)
		label.textColor = textColor
		return label
	}
	
	/** A label with a font, a color and an alignment. */
	@objc(labelWithFrame:font:textColor:textAlignment:)
	open class func label(frame: CGRect, font: UIFont, textColor: UIColor, textAlignment alignment: NSTextAlignment) -> Self {
		let label = self.label(frame: frame, font: font, textColor: textColor)
		label.textAlignment = alignment
		return label
	}
	
	/** A label with attributed text and an alignment. */
	@objc(labelWithFrame:attributedText:textAlignment:)
	open class func label(frame: CGRect, attributedText: NSAttributedString?, textAlignment alignment: NSTextAlignment) -> Self {
		let label = self.init(frame: frame)
		label.attributedText = attributedText
		label.textAlignment = alignment
		return label
	}
	
	/** Creates a label with attributed text, a font, a color and an alignment. */
	@objc(initWithFrame:attributedText:font:textColor:textAlignment:)
	public convenience init(frame: CGRect, attributedText: NSAttributedString?, font: UIFont, textColor: UIColor, textAlignment alignment: NSTextAlignment) {
		self.init(frame: frame)
		self.textColor = textColor
		self.font = font
		self.attributedText = attributedText
		self.textAlignment = alignment
	}
	
	/** Creates a label with text, a font, a color and an alignment. */
	@objc(initWithFrame:text:font:textColor:textAlignment:)
	public convenience init(frame: CGRect, text: String?, font: UIFont, textColor: UIColor, textAlignment alignment: NSTextAlignment) {
		self.init(frame: frame, font: font, textColor: textColor, textAlignment: alignment)
		self.text = text
	}
	
	/** Creates a label with a font. */
	@objc(initWithFrame:font:)
	public convenience init(frame: CGRect, font: UIFont) {
		self.init(frame: frame)
		self.font = font
	}
	
	/** Creates a label with a font and a color. */
	@objc(initWithFrame:font:textColor:)
	public convenience init(frame: CGRect, font: UIFont, textColor: UIColor) {
		self.init(frame: frame, font: font)
		self.textColor = textColor
	}
	
	/** Creates a label with a font, a color and an alignment. */
	@objc(initWithFrame:font:textColor:textAlignment:)
	public convenience init(frame: CGRect, font: UIFont, textColor: UIColor, textAlignment alignment: NSTextAlignment) {
		self.init(frame: frame, font: font, textColor: textColor)
		self.textAlignment = alignment
	}
	
	/** Creates a label with attributed text and an alignment. */
	@objc(initWithFrame:attributedText:textAlignment:)
	public convenience init(frame: CGRect, attributedText: NSAttributedString?, textAlignment alignment: NSTextAlignment) {
		self.init(frame: frame)
		self.attributedText = attributedText
		self.textAlignment = alignment
	}
	
}
