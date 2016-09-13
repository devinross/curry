//
//  UILabel+Initializers.h
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

@import UIKit;

/** Introduces initializer helpers `UILabel`. */
@interface UILabel (Initializers)


/** Creates and returns a newly allocated label object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param attributedText The attributed text.
 @param font The font set to the font.
 @param textColor The text color.
 @param alignment The text alignment of the label.
 @return An initialized label object or nil if the object couldn't be created.
 */
+ (nonnull instancetype) labelWithFrame:(CGRect)frame attributedText:(NSAttributedString* _Nullable )attributedText font:(UIFont* _Nonnull )font textColor:(UIColor* _Nonnull)textColor textAlignment:(NSTextAlignment)alignment;

/** Initializes and returns a newly allocated label object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param attributedText The attributed text.
 @param font The font set to the font.
 @param textColor The text color.
 @param alignment The text alignment of the label.
 @return An initialized label object or nil if the object couldn't be created.
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame attributedText:(NSAttributedString* _Nullable)attributedText font:(UIFont* _Nonnull)font textColor:(UIColor*_Nonnull )textColor textAlignment:(NSTextAlignment)alignment;



/** Creates and returns a newly allocated label object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param text The text.
 @param font The font set to the font.
 @param textColor The text color.
 @param alignment The text alignment of the label.
 @return An initialized label object or nil if the object couldn't be created.
 */
+ (nonnull instancetype) labelWithFrame:(CGRect)frame text:(NSString* _Nullable)text font:(UIFont* _Nonnull)font textColor:(UIColor* _Nonnull)textColor textAlignment:(NSTextAlignment)alignment;


/** Initializes and returns a newly allocated label object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param text The text.
 @param font The font set to the font.
 @param textColor The text color.
 @param alignment The text alignment of the label.
 @return An initialized label object or nil if the object couldn't be created.
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame text:(NSString* _Nullable)text font:(UIFont* _Nonnull)font textColor:(UIColor* _Nonnull)textColor textAlignment:(NSTextAlignment)alignment;




/** Creates and returns a newly allocated label object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param font The font set to the font.
 @return An initialized label object or nil if the object couldn't be created.
 */
+ (nonnull instancetype) labelWithFrame:(CGRect)frame font:(UIFont* _Nonnull)font;

/** Initializes and returns a newly allocated label object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param font The font set to the font.
 @return An initialized label object or nil if the object couldn't be created.
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame font:(UIFont* _Nonnull)font;



/** Initializes and returns a newly allocated label object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param font The font set to the font.
 @param textColor The text color.
 @return An initialized label object or nil if the object couldn't be created.
 */
+ (nonnull instancetype) labelWithFrame:(CGRect)frame font:(UIFont* _Nonnull)font textColor:(UIColor* _Nonnull)textColor;

/** Initializes and returns a newly allocated label object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param font The font set to the font.
 @param textColor The text color.
 @return An initialized label object or nil if the object couldn't be created.
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame font:(UIFont* _Nonnull)font textColor:(UIColor* _Nonnull)textColor;



/** Creates and returns a newly allocated view object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param font The font set to the font.
 @param textColor The text color.
 @param alignment The text alignment of the label.
 @return An initialized view object or nil if the object couldn't be created.
 */
+ (nonnull instancetype) labelWithFrame:(CGRect)frame font:(UIFont* _Nonnull)font textColor:(UIColor* _Nonnull)textColor textAlignment:(NSTextAlignment)alignment;

/** Creates and returns a newly allocated view object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param font The font set to the font.
 @param textColor The text color.
 @param alignment The text alignment of the label.
 @return An initialized view object or nil if the object couldn't be created.
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame font:(UIFont* _Nonnull)font textColor:(UIColor* _Nonnull)textColor textAlignment:(NSTextAlignment)alignment;



/** Creates and returns a newly allocated view object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param attributedText The attributed text.
 @param alignment The text alignment of the label.
 @return An initialized view object or nil if the object couldn't be created.
 */
+ (nonnull instancetype) labelWithFrame:(CGRect)frame attributedText:(NSAttributedString* _Nullable)attributedText textAlignment:(NSTextAlignment)alignment;

/** Creates and returns a newly allocated view object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param attributedText The attributed text.
 @param alignment The text alignment of the label.
 @return An initialized view object or nil if the object couldn't be created.
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame attributedText:(NSAttributedString* _Nullable)attributedText textAlignment:(NSTextAlignment)alignment;



@end
