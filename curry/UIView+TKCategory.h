//
//  UIViewAdditions.h
//  Created by Devin Ross on 7/25/09.
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
@import QuartzCore;

/** Additional functionality for `UIView`.  */
@interface UIView (TKCategory)

/** Adds a view to the beginning of the receiver’s list of subviews.
 @param view The view to be added. This view is retained by the receiver. After being added, this view appears below of any other subviews.
 */
- (void) addSubviewToBack:(UIView*)view;



- (UIImage*) snapshotImageAfterScreenUpdates:(BOOL)updates;

- (void) setShadowWithOffset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;
- (void) setShadowWithOffset:(CGSize)offset opacity:(CGFloat)opacity color:(UIColor*)color radius:(CGFloat)radius;
- (void) setShadowWithPath:(UIBezierPath*)bezierPath offset:(CGSize)offset opacity:(CGFloat)opacity color:(UIColor*)color radius:(CGFloat)radius;
- (void) setBorderWithColor:(UIColor*)color width:(CGFloat)width;

@property (nonatomic,assign) CGFloat cornerRadius;


@end