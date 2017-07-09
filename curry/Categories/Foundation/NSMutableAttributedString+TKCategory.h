//
//  NSMutableAttributedString+TKCategory.h
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

@import Foundation;
@import UIKit;

/** Additional functionality for `NSMutableAttributedString`.  */
@interface NSMutableAttributedString (TKCategory)



/** Set the text color of a range of characters.
 @param color The color that will be set.
 @param range The range of text that will be set as the color.
 */
- (void) addTextColor:(UIColor*)color range:(NSRange)range;

/** Set the text color of the string.
 @param color The color that will be set.
 */
- (void) addTextColor:(UIColor *)color;



/** Set the font of a range of characters.
 @param font The font that will be set.
 @param range The range of text that will be set as the color.
 */
- (void) addFont:(UIFont*)font range:(NSRange)range;

/** Set the font of the string.
 @param font The font that will be set.
 */
- (void) addFont:(UIFont*)font;



/** Set the kerning of the text in a range.
 @param kerning The kerning that will be set.
 @param range The range of text that will be set as the color.
 */
- (void) addKerning:(CGFloat)kerning range:(NSRange)range;

/** Set the font of the string.
 @param kerning The font that will be set.
 */
- (void) addKerning:(CGFloat)kerning;



/** Set the line height for the text in a range.
 @param lineHeight The line height that will be set.
 @param range The range of text that will be set as the color.
 */
- (void) addLineHeight:(CGFloat)lineHeight range:(NSRange)range;

/** Set the font of the string.
 @param lineHeight The font that will be set.
 */
- (void) addLineHeight:(CGFloat)lineHeight;

/** Set the background color of the string.
 @param color The color that will be set.
 @param range The range of text that will be set as the color.
 */
- (void) addBackgroundColor:(UIColor*)color range:(NSRange)range;

/** Set the background color of the string.
 @param color The color that will be set.
 */
- (void) addBackgroundColor:(UIColor *)color;




- (void) appendImage:(UIImage*)image;

- (void) insertImage:(UIImage*)image atIndex:(NSUInteger)index;

@end
