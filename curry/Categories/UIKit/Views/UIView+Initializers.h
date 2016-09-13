//
//  UIView+Initializers.h
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

/** Introduces initializer helpers `UIView`. */
@interface UIView (Initializers)



/** Creates and returns a newly allocated view object with the specified frame rectangle.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @return An initialized view object or nil if the object couldn't be created.
 */
+ (nonnull instancetype) viewWithFrame:(CGRect)frame;

/** Initializes and returns a newly allocated view object with the specified frame rectangle and background color.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param backgroundColor The views background color.
 @return An initialized view object or nil if the object couldn't be created.
 */
+ (nonnull instancetype) viewWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor;


/** Creates and returns a newly allocated view object with the specified frame rectangle and background color.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param backgroundColor The views background color.
 @return An initialized view object or nil if the object couldn't be created.
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor;

/** Creates and returns a newly allocated view object with the specified frame rectangle and background color.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param backgroundColor The views background color.
 @param cornerRadius The corner radius of the view.
 @return An initialized view object or nil if the object couldn't be created.
 */
+ (nonnull instancetype) viewWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor cornerRadius:(CGFloat)cornerRadius;


/** Initializes and returns a newly allocated view object with the specified frame rectangle and background color.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param backgroundColor The views background color.
 @param cornerRadius The corner radius of the view.
 @return An initialized view object or nil if the object couldn't be created.
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor cornerRadius:(CGFloat)cornerRadius;


/** Creates and returns a newly allocated view object with the specified frame rectangle and background color.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param backgroundColor The views background color.
 @param cornerRadius The corner radius of the view.
 @param borderColor The border color of the view.
 @param borderWidth The border width.
 @return An initialized view object or nil if the object couldn't be created.
 */
+ (nonnull instancetype) viewWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor cornerRadius:(CGFloat)cornerRadius borderColor:(nonnull UIColor*)borderColor borderWidth:(CGFloat)borderWidth;

/** Initializes and returns a newly allocated view object with the specified frame rectangle and background color.
 @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 @param backgroundColor The views background color.
 @param cornerRadius The corner radius of the view.
 @param borderColor The border color of the view.
 @param borderWidth The border width.
 @return An initialized view object or nil if the object couldn't be created.
 */
- (nonnull instancetype) initWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor cornerRadius:(CGFloat)cornerRadius borderColor:(nonnull UIColor*)borderColor borderWidth:(CGFloat)borderWidth;

@end
