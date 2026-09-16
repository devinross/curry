//
//  NSString+TKUIKit.swift
//  Created by Devin Ross on 10/13/16.
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


extension NSString {
	
	/** The height needed to draw the string within a given width.
	@param width The width the text is constrained to.
	@param font The font the text is drawn with.
	@return The needed height, always at least one row tall.
	*/
	@objc(heightForWidth:andFont:)
	public func heightForWidth(_ width: CGFloat, andFont font: UIFont) -> CGFloat {
		let minimum = font.pointSize + 4
		let constraint = CGSize(width: width, height: .greatestFiniteMagnitude)
		let frame = boundingRect(with: constraint,
		                         options: .usesLineFragmentOrigin,
		                         attributes: [.font: font],
		                         context: nil)
		return max(frame.size.height + 1, minimum) // At least one row
	}
	
}
