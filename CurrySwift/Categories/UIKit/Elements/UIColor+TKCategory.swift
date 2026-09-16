//
//  UIColor+TKCategory.swift
//  Created by Devin Ross on 5/14/11.
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


/** Additional functionality for `UIColor`. */
extension UIColor {
	
	/** Creates and returns a color object using the specific hex value.
	@param hex The hex value that will decide the color.
	@return The `UIColor` object.
	*/
	@objc(colorWithHex:)
	open class func color(hex: UInt32) -> UIColor {
		color(hex: hex, alpha: 1)
	}
	
	/** Creates and returns a color object using the specific hex value.
	@param hex The hex value that will decide the color.
	@param alpha The opacity of the color.
	@return The `UIColor` object.
	*/
	@objc(colorWithHex:alpha:)
	open class func color(hex: UInt32, alpha: CGFloat) -> UIColor {
		UIColor(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
		        green: CGFloat((hex & 0xFF00) >> 8) / 255.0,
		        blue: CGFloat(hex & 0xFF) / 255.0,
		        alpha: alpha)
	}
	
	/** Creates and returns a color object using the specific hex value.
	@param hexString The hex value that will decide the color.
	@return The `UIColor` object.
	*/
	@objc(colorWithHexString:)
	open class func color(hexString: String) -> UIColor {
		color(hexString: hexString, alpha: 1.0)
	}
	
	/** Creates and returns a color object using the specific hex value.
	@param hexString The hex value that will decide the color.
	@param alpha The opacity of the color.
	@return The `UIColor` object.
	*/
	@objc(colorWithHexString:alpha:)
	open class func color(hexString: String, alpha: CGFloat) -> UIColor {
		
		var digits = hexString
		if digits.hasPrefix("#") {
			digits.removeFirst()
		} else if digits.hasPrefix("0x") {
			digits.removeFirst(2)
		}
		
		let scanner = Scanner(string: digits)
		let rgb = scanner.scanUInt64(representation: .hexadecimal) ?? 0
		
		return color(hex: UInt32(truncatingIfNeeded: rgb), alpha: alpha)
	}
	
	/** Creates and returns a color object with a random color value. The alpha property is 1.0. */
	@objc open class var randomColor: UIColor {
		randomColor(alpha: 1)
	}
	
	/** Creates and returns a color object with a random color value.
	@param alpha The alpha of the color.
	*/
	@objc(randomColorWithAlpha:)
	open class func randomColor(alpha: CGFloat) -> UIColor {
		UIColor(red: CGFloat.random(in: 0...1),
		        green: CGFloat.random(in: 0...1),
		        blue: CGFloat.random(in: 0...1),
		        alpha: alpha)
	}
	
}
