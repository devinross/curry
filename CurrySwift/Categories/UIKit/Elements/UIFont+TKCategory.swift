//
//  UIFont+TKCategory.swift
//  Created by Devin Ross on 10/5/13.
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


extension UIFont {
	
	// MARK: - Helvetica Neue
	/** The HelveticaNeue font at the given size. */
	@objc(helveticaNeueWithSize:)
	open class func helveticaNeue(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue", size: size)
	}
	
	/** The HelveticaNeue-BoldItalic font at the given size. */
	@objc(helveticaNeueBoldItalicWithSize:)
	open class func helveticaNeueBoldItalic(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-BoldItalic", size: size)
	}
	
	/** The HelveticaNeue-Light font at the given size. */
	@objc(helveticaNeueLightWithSize:)
	open class func helveticaNeueLight(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-Light", size: size)
	}
	
	/** The HelveticaNeue-Italic font at the given size. */
	@objc(helveticaNeueItalicWithSize:)
	open class func helveticaNeueItalic(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-Italic", size: size)
	}
	
	/** The HelveticaNeue-UltraLightItalic font at the given size. */
	@objc(helveticaNeueUltraLightItalicWithSize:)
	open class func helveticaNeueUltraLightItalic(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-UltraLightItalic", size: size)
	}
	
	/** The HelveticaNeue-CondensedBold font at the given size. */
	@objc(helveticaNeueCondensedBoldWithSize:)
	open class func helveticaNeueCondensedBold(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-CondensedBold", size: size)
	}
	
	/** The HelveticaNeue-MediumItalic font at the given size. */
	@objc(helveticaNeueMediumItalicWithSize:)
	open class func helveticaNeueMediumItalic(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-MediumItalic", size: size)
	}
	
	/** The HelveticaNeue-Medium font at the given size. */
	@objc(helveticaNeueMediumWithSize:)
	open class func helveticaNeueMedium(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-Medium", size: size)
	}
	
	/** The HelveticaNeue-ThinItalic font at the given size. */
	@objc(helveticaNeueThinItalicWithSize:)
	open class func helveticaNeueThinItalic(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-ThinItalic", size: size)
	}
	
	/** The HelveticaNeue-Thin font at the given size. */
	@objc(helveticaNeueThinWithSize:)
	open class func helveticaNeueThin(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-Thin", size: size)
	}
	
	/** The HelveticaNeue-LightItalic font at the given size. */
	@objc(helveticaNeueLightItalicWithSize:)
	open class func helveticaNeueLightItalic(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-LightItalic", size: size)
	}
	
	/** The HelveticaNeue-UltraLight font at the given size. */
	@objc(helveticaNeueUltraLightWithSize:)
	open class func helveticaNeueUltraLight(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-UltraLight", size: size)
	}
	
	/** The HelveticaNeue-Bold font at the given size. */
	@objc(helveticaNeueBoldWithSize:)
	open class func helveticaNeueBold(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-Bold", size: size)
	}
	
	/** The HelveticaNeue-CondensedBlack font at the given size. */
	@objc(helveticaNeueCondensedBlackWithSize:)
	open class func helveticaNeueCondensedBlack(size: CGFloat) -> UIFont? {
		UIFont(name: "HelveticaNeue-CondensedBlack", size: size)
	}
	
	// MARK: - Avenir
	/** The Avenir-Heavy font at the given size. */
	@objc(avenirHeavyWithSize:)
	open class func avenirHeavy(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-Heavy", size: size)
	}
	
	/** The Avenir-Oblique font at the given size. */
	@objc(avenirObliqueWithSize:)
	open class func avenirOblique(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-Oblique", size: size)
	}
	
	/** The Avenir-Black font at the given size. */
	@objc(avenirBlackWithSize:)
	open class func avenirBlack(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-Black", size: size)
	}
	
	/** The Avenir-Book font at the given size. */
	@objc(avenirBookWithSize:)
	open class func avenirBook(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-Book", size: size)
	}
	
	/** The Avenir-BlackOblique font at the given size. */
	@objc(avenirBlackObliqueWithSize:)
	open class func avenirBlackOblique(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-BlackOblique", size: size)
	}
	
	/** The Avenir-HeavyOblique font at the given size. */
	@objc(avenirHeavyObliqueWithSize:)
	open class func avenirHeavyOblique(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-HeavyOblique", size: size)
	}
	
	/** The Avenir-Light font at the given size. */
	@objc(avenirLightWithSize:)
	open class func avenirLight(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-Light", size: size)
	}
	
	/** The Avenir-MediumOblique font at the given size. */
	@objc(avenirMediumObliqueWithSize:)
	open class func avenirMediumOblique(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-MediumOblique", size: size)
	}
	
	/** The Avenir-Medium font at the given size. */
	@objc(avenirMediumWithSize:)
	open class func avenirMedium(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-Medium", size: size)
	}
	
	/** The Avenir-LightOblique font at the given size. */
	@objc(avenirLightObliqueWithSize:)
	open class func avenirLightOblique(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-LightOblique", size: size)
	}
	
	/** The Avenir-Roman font at the given size. */
	@objc(avenirRomanWithSize:)
	open class func avenirRoman(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-Roman", size: size)
	}
	
	/** The Avenir-BookOblique font at the given size. */
	@objc(avenirBookObliqueWithSize:)
	open class func avenirBookOblique(size: CGFloat) -> UIFont? {
		UIFont(name: "Avenir-BookOblique", size: size)
	}
	
	// MARK: - Dynamic Type point sizes
	
	/// How far the point size moves from its base, in `delta` steps, per content size category.
	///
	/// `large` is the baseline: negative steps shrink, positive steps grow.
	private static func largeSteps(for category: UIContentSizeCategory) -> CGFloat {
		switch category {
			case .medium:                             return -1
			case .large:                              return 0
			case .extraLarge:                         return 1
			case .extraExtraLarge:                    return 2
			case .extraExtraExtraLarge:               return 3
			case .accessibilityMedium:                return 4
			case .accessibilityLarge:                 return 4
			case .accessibilityExtraLarge:            return 5
			case .accessibilityExtraExtraLarge:       return 6
			case .accessibilityExtraExtraExtraLarge:  return 7
			case .small:                              return -2
			case .extraSmall:                         return -3
			default:                                  return 0
		}
	}
	
	private static var preferredContentSizeCategory: UIContentSizeCategory {
		UIApplication.shared.preferredContentSizeCategory
	}
	
	/** Picks an explicit point size per content size category.
	@param xs The size used at the extra small category.
	@param s The size used at the small category.
	@param m The size used at the medium category, and as the fallback.
	@param l The size used at the large category.
	@param xl The size used at the extra large category.
	@param xxl The size used at the extra extra large category.
	@param xxxl The size used at the extra extra extra large category.
	*/
	@objc(pointSizeWithXS:s:m:l:xl:xxl:xxxl:)
	open class func pointSize(xs: CGFloat, s: CGFloat, m: CGFloat, l: CGFloat, xl: CGFloat, xxl: CGFloat, xxxl: CGFloat) -> CGFloat {
		switch preferredContentSizeCategory {
			case .accessibilityMedium:                    return m
			case .accessibilityLarge, .large:             return l
			case .accessibilityExtraLarge, .extraLarge:   return xl
			case .extraExtraLarge:                        return xxl
			case .extraExtraExtraLarge:                   return xxxl
			case .small:                                  return s
			case .extraSmall:                             return xs
			default:                                      return m
		}
	}
	
	/** Scales a point size around the medium category.
	@param m The size at the medium category.
	@param scale The size at one category larger, as a multiple of `m`.
	*/
	@objc(pointSizeWithMedium:scaleFactor:)
	open class func pointSize(medium m: CGFloat, scaleFactor scale: CGFloat) -> CGFloat {
		// The medium scale runs one step "later" than the large scale.
		let steps = largeSteps(for: preferredContentSizeCategory) + 1
		return m + (m * scale - m) * steps
	}
	
	/** Scales a point size around the large category.
	@param l The size at the large category.
	@param scale The size at one category larger, as a multiple of `l`.
	*/
	@objc(pointSizeWithLarge:scaleFactor:)
	open class func pointSize(large l: CGFloat, scaleFactor scale: CGFloat) -> CGFloat {
		pointSize(large: l, upScaleFactor: scale, downScaleFactor: scale)
	}
	
	/** Scales a point size around the large category, growing and shrinking at different rates.
	@param l The size at the large category.
	@param upScale The size at one category larger, as a multiple of `l`.
	@param downScale The size at one category smaller, as a multiple of `l`.
	*/
	@objc(pointSizeWithLarge:upScaleFactor:downScaleFactor:)
	open class func pointSize(large l: CGFloat, upScaleFactor upScale: CGFloat, downScaleFactor downScale: CGFloat) -> CGFloat {
		let steps = largeSteps(for: preferredContentSizeCategory)
		let delta = steps < 0 ? l * downScale - l : l * upScale - l
		return l + delta * steps
	}
	
}
