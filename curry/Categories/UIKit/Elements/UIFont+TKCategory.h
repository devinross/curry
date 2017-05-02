//
//  UIFont+TKCategory.h
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

@import UIKit;

@interface UIFont (TKCategory)

#pragma mark Helvetica Neue

/* Returns a Helvetica Neue font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Bold Italic font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueBoldItalicWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Light font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueLightWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Italic font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueItalicWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Light Italic font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueUltraLightItalicWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Condensed Bold font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueCondensedBoldWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Medium Italic font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueMediumItalicWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Medium font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueMediumWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Thin Italic font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueThinItalicWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Light Italic font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueLightItalicWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Ultra Light font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueUltraLightWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Bold font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueBoldWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Condensed Black font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueCondensedBlackWithSize:(CGFloat)size;

/* Returns a Helvetica Neue Thin font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) helveticaNeueThinWithSize:(CGFloat)size;

#pragma mark Avenir
/* Returns a Avenir Heavy font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirHeavyWithSize:(CGFloat)size;

/* Returns a Avenir Oblique font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirObliqueWithSize:(CGFloat)size;

/* Returns a Avenir Black font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirBlackWithSize:(CGFloat)size;

/* Returns a Avenir Book font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirBookWithSize:(CGFloat)size;

/* Returns a Avenir Black Oblique font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirBlackObliqueWithSize:(CGFloat)size;

/* Returns a Avenir Heavy Oblique font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirHeavyObliqueWithSize:(CGFloat)size;

/* Returns a Avenir Light font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirLightWithSize:(CGFloat)size;

/* Returns a Avenir Oblique font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirMediumObliqueWithSize:(CGFloat)size;

/* Returns a Avenir Medium font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirMediumWithSize:(CGFloat)size;

/* Returns a Avenir Light Oblique font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirLightObliqueWithSize:(CGFloat)size;

/* Returns a Avenir Roman font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirRomanWithSize:(CGFloat)size;

/* Returns a Avenir font.
 @param size The font size.
 @return A `UIFont` with the given size.
 */
+ (UIFont*) avenirBookObliqueWithSize:(CGFloat)size;



+ (CGFloat) pointSizeWithXS:(CGFloat)xs s:(CGFloat)s m:(CGFloat)m l:(CGFloat)l xl:(CGFloat)xl xxl:(CGFloat)xxl xxxl:(CGFloat)xxxl;
+ (CGFloat) pointSizeWithMedium:(CGFloat)m scaleFactor:(CGFloat)scale;
+ (CGFloat) pointSizeWithLarge:(CGFloat)l scaleFactor:(CGFloat)scale;
+ (CGFloat) pointSizeWithLarge:(CGFloat)l upScaleFactor:(CGFloat)upScale downScaleFactor:(CGFloat)downScale;

@end
