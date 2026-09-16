//
//  NSMutableAttributedString+TKCategory.swift
//  Created by Devin Ross on 12/16/14.
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
import UIKit
import CoreText


/** Additional functionality for `NSMutableAttributedString`. */
extension NSMutableAttributedString {
	
	private var fullRange: NSRange { NSRange(location: 0, length: length) }
	
	/** Set the text color of a range of characters.
	@param color The color that will be set.
	@param range The range of text that will be set as the color.
	*/
	@objc(addTextColor:range:)
	public func addTextColor(_ color: UIColor, range: NSRange) {
		addAttribute(.foregroundColor, value: color, range: range)
	}
	
	/** Set the text color of the string.
	@param color The color that will be set.
	*/
	@objc(addTextColor:)
	public func addTextColor(_ color: UIColor) {
		addTextColor(color, range: fullRange)
	}
	
	/** Set the background color of a range of characters.
	@param color The color that will be set.
	@param range The range of text that will be set as the color.
	*/
	@objc(addBackgroundColor:range:)
	public func addBackgroundColor(_ color: UIColor, range: NSRange) {
		addAttribute(.backgroundColor, value: color, range: range)
	}
	
	/** Set the background color of the string.
	@param color The color that will be set.
	*/
	@objc(addBackgroundColor:)
	public func addBackgroundColor(_ color: UIColor) {
		addBackgroundColor(color, range: fullRange)
	}
	
	/** Set the font of a range of characters.
	@param font The font that will be set.
	@param range The range of text that will be set as the font.
	*/
	@objc(addFont:range:)
	public func addFont(_ font: UIFont, range: NSRange) {
		addAttribute(.font, value: font, range: range)
	}
	
	/** Set the font of the string.
	@param font The font that will be set.
	*/
	@objc(addFont:)
	public func addFont(_ font: UIFont) {
		addFont(font, range: fullRange)
	}
	
	/** Set the kerning of the text in a range.
	@param kerning The kerning that will be set.
	@param range The range of text that will be set as the kerning.
	*/
	@objc(addKerning:range:)
	public func addKerning(_ kerning: CGFloat, range: NSRange) {
		addAttribute(.kern, value: kerning, range: range)
	}
	
	/** Set the kerning of the string.
	@param kerning The kerning that will be set.
	*/
	@objc(addKerning:)
	public func addKerning(_ kerning: CGFloat) {
		addKerning(kerning, range: fullRange)
	}
	
	/** Set the line height for the text in a range.
	@param lineHeight The line height that will be set.
	@param range The range of text that will be set as the line height.
	*/
	@objc(addLineHeight:range:)
	public func addLineHeight(_ lineHeight: CGFloat, range: NSRange) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = lineHeight
		addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
	}
	
	/** Set the line height of the string.
	@param lineHeight The line height that will be set.
	*/
	@objc(addLineHeight:)
	public func addLineHeight(_ lineHeight: CGFloat) {
		addLineHeight(lineHeight, range: fullRange)
	}
	
	#if !os(watchOS)
	
	/** Append an image to the end of the string.
	@param image The image that will be appended.
	*/
	@objc(appendImage:)
	public func appendImage(_ image: UIImage) {
		append(NSAttributedString(attachment: attachment(for: image)))
	}
	
	/** Insert an image at a given index.
	@param image The image that will be inserted.
	@param index The index the image will be inserted at.
	*/
	@objc(insertImage:atIndex:)
	public func insertImage(_ image: UIImage, at index: Int) {
		insert(NSAttributedString(attachment: attachment(for: image)), at: index)
	}
	
	private func attachment(for image: UIImage) -> NSTextAttachment {
		let attachment = NSTextAttachment()
		attachment.image = image
		return attachment
	}
	
	#endif
	
}
