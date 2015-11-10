//
//  UIMotionEffectGroup+TKCategory.m
//  Created by Devin Ross on 11/9/15.
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

#import "UIMotionEffectGroup+TKCategory.h"

@implementation UIMotionEffectGroup (TKCategory)


+ (UIMotionEffectGroup*) parallaxMotionEffectGroupWithXAngle:(CGFloat)xAngle yAngle:(CGFloat)yAngle xMove:(CGFloat)xMove yMove:(CGFloat)yMove{
	
	UIInterpolatingMotionEffect *xRot = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.transform" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	UIInterpolatingMotionEffect *yRot = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.transform" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	UIInterpolatingMotionEffect *xMov = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
	UIInterpolatingMotionEffect *yMov = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
	
	xMov.minimumRelativeValue = @(-xMove);
	xMov.maximumRelativeValue = @(xMove);
	yMov.minimumRelativeValue = @(-yMove);
	yMov.maximumRelativeValue = @(yMove);
	
	CATransform3D base = CATransform3DIdentity;
	base.m34 = 1.0f / 1000;
	CATransform3D min = CATransform3DRotate(base, yAngle * M_PI / 180.0f, 1, 0, 0);
	CATransform3D max = CATransform3DRotate(base, yAngle * M_PI / 180.0f, -1, 0, 0);
	yRot.minimumRelativeValue = [NSValue valueWithCATransform3D:min];
	yRot.maximumRelativeValue = [NSValue valueWithCATransform3D:max];
	
	
	min = CATransform3DRotate(base, xAngle * M_PI / 180.0f, 0, -1, 0);
	max = CATransform3DRotate(base, xAngle * M_PI / 180.0f, 0, 1, 0);
	xRot.minimumRelativeValue = [NSValue valueWithCATransform3D:min];
	xRot.maximumRelativeValue = [NSValue valueWithCATransform3D:max];
	
	UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
	group.motionEffects = @[xMov,yMov,yRot,xRot];
	
	return group;
}


@end
