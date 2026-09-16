//
//  NSAttributedString+TKCategory.swift
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


/** Additional functionality for `NSAttributedString`. */
extension NSAttributedString {
	
	/** Creates an attributed string with a line height.
	@param text The text of the string.
	@param lineHeight The line height of the attributed string.
	@return A `NSAttributedString` object, or nil when the text is empty.
	*/
	@objc(attributedStringWithText:lineHeight:)
	public static func attributedString(text: String, lineHeight: CGFloat) -> NSAttributedString? {
		makeAttributedString(text: text, lineHeight: lineHeight, kerning: nil)
	}
	
	/** Creates an attributed string with a specific kerning.
	@param text The text of the string.
	@param kerning The kerning of the attributed string.
	@return A `NSAttributedString` object, or nil when the text is empty.
	*/
	@objc(attributedStringWithText:kerning:)
	public static func attributedString(text: String, kerning: CGFloat) -> NSAttributedString? {
		makeAttributedString(text: text, lineHeight: nil, kerning: kerning)
	}
	
	/** Creates an attributed string with both a line height and a kerning.
	@param text The text of the string.
	@param lineHeight The line height of the attributed string.
	@param kerning The kerning of the attributed string.
	@return A `NSAttributedString` object, or nil when the text is empty.
	*/
	@objc(attributedStringWithText:lineHeight:kerning:)
	public static func attributedString(text: String, lineHeight: CGFloat, kerning: CGFloat) -> NSAttributedString? {
		makeAttributedString(text: text, lineHeight: lineHeight, kerning: kerning)
	}
	
	private static func makeAttributedString(text: String, lineHeight: CGFloat?, kerning: CGFloat?) -> NSAttributedString? {
		guard !text.isEmpty else { return nil }
		
		let attributed = NSMutableAttributedString(string: text)
		let range = NSRange(location: 0, length: attributed.length)
		
		if let lineHeight {
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.lineSpacing = lineHeight
			attributed.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
		}
		
		if let kerning {
			attributed.addAttribute(.kern, value: kerning, range: range)
		}
		
		return attributed
	}
	
}
