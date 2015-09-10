//
//  UIView+Postioning.h
//  Created by Devin Ross on 4/17/15.
//
/*
 
 curry || https://github.com/devinross/curry-fire
 
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

/** Additional functionality dealing with `UIView` positioning. */
@interface UIView (Positioning)

/** Converts the view's center coordinate to a view.
 @param view The given view to translate to.
 @return The point the correlates to the center of the view on the given view.
 */
- (CGPoint) convertCenterToView:(UIView*)view;

/** Converts the view's frame to a view.
 @param view The given view to translate to.
 @return The `CGRect` the correlates to the center of the view on the given view.
 */
- (CGRect) convertFrameToView:(UIView*)view;

/** Moves the view to a different superview while maintaining its overall position.
 @param view The view that will hold the view.
 */
- (void) moveToView:(UIView*)view;

/** Moves the view to the back of a different superview while maintaining its overall position.
 @param view The view that will hold the view.
 */
- (void) moveToBackOfView:(UIView*)view;

/** The coordinate at the middle of the view */
@property (nonatomic,readonly) CGPoint middle;

/** The width of the view's frame. */
@property (nonatomic,assign) CGFloat width;

/** The height of the view's frame. */
@property (nonatomic,assign) CGFloat height;

/** The size of the view's frame. */
@property (nonatomic,assign) CGSize size;

/** The origin of the view's frame. */
@property (nonatomic,assign) CGPoint origin;

/** The x origin of the view's frame. */
@property (nonatomic,assign) CGFloat minX;

/** The y origin of the view's frame. */
@property (nonatomic,assign) CGFloat minY;

/** The max x origin of the view's frame. */
@property (nonatomic,assign) CGFloat maxX;

/** The max y origin of the view's frame. */
@property (nonatomic,assign) CGFloat maxY;

/** The x origin of the view's frame. */
@property (nonatomic,assign) CGFloat originX;

/** The max y origin of the view's frame. */
@property (nonatomic,assign) CGFloat originY;

/** The views center x position. */
@property (nonatomic,assign) CGFloat centerX;

/** The views center y position. */
@property (nonatomic,assign) CGFloat centerY;

@end
