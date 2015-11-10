//
//  UIViewAdditions.m
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
#import "UIView+TKCategory.h"


@implementation UIView (TKCategory)


- (BOOL) visible{
	return !self.hidden;
}
- (void) setVisible:(BOOL)visible{
	self.hidden = !visible;
}

- (void) addSubviewToBack:(UIView*)view{
	[self insertSubview:view atIndex:0];
}

- (void) setShadowWithOffset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius{
    [self setShadowWithOffset:offset opacity:opacity color:[UIColor blackColor] radius:radius];
}
- (void) setShadowWithOffset:(CGSize)offset opacity:(CGFloat)opacity color:(UIColor*)color radius:(CGFloat)radius{
    [self setShadowWithPath:[UIBezierPath bezierPathWithRect:self.bounds] offset:offset opacity:opacity color:color radius:radius];
}
- (void) setShadowWithPath:(UIBezierPath*)bezierPath offset:(CGSize)offset opacity:(CGFloat)opacity color:(UIColor*)color radius:(CGFloat)radius{
    self.layer.shadowPath = bezierPath.CGPath;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = radius;
}



- (void) setBorderWithColor:(UIColor*)color width:(CGFloat)width{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}
- (void) setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}
- (CGFloat) cornerRadius{
    return self.layer.cornerRadius;
}

- (UIImage*) snapshotImageAfterScreenUpdates:(BOOL)updates{
	
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, [UIScreen mainScreen].scale);
	[self drawViewHierarchyInRect:self.bounds  afterScreenUpdates:updates];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	return img;
}


- (void) removeAllGestureRecognizers{
	for(NSInteger i=self.gestureRecognizers.count-1;i>=0;i--){
		[self removeGestureRecognizer:self.gestureRecognizers[i]];
	}
}


- (BOOL) hasSuperview:(UIView*)parentView{
	if(parentView == self.superview)
		return YES;
	if(!self.superview)
		return NO;
	return [self hasSuperview:self.superview];
}

- (void) removeAllMotionEffects{
	
	NSArray *effects = self.motionEffects.copy;
	for(UIMotionEffect *effect in effects){
		[self removeMotionEffect:effect];
	}
	
}


@end
