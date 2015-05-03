//
//  UIView+TKAnimation.m
//  Created by Devin Ross on 12/22/14.
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

#import "UIView+TKAnimation.h"
#import "UIView+TKCategory.h"
#import "CALayer+TKAnimation.h"
#import "CAAnimation+TKAnimation.h"

NSString *TKViewAnimationKeyPathCenter = @"position";
NSString *TKViewAnimationKeyPathCenterX = @"position.x";
NSString *TKViewAnimationKeyPathCenterY = @"position.y";
NSString *TKViewAnimationKeyPathTransform = @"transform";
NSString *TKViewAnimationKeyPathFrame = @"frame";
NSString *TKViewAnimationKeyPathOrigin = @"origin";
NSString *TKViewAnimationKeyPathOriginX = @"origin.x";
NSString *TKViewAnimationKeyPathOriginY = @"origin.y";
NSString *TKViewAnimationKeyPathSize = @"size";
NSString *TKViewAnimationKeyPathSizeWidth = @"size.width";
NSString *TKViewAnimationKeyPathSizeHeight = @"size.height";

@implementation UIView (TKAnimation)


#pragma mark Keyframe Animations
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay path:(CGPathRef)path options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion{
    [self.layer addKeyframeAnimationWithKeyPath:keyPath duration:duration delay:delay path:path options:options completion:completion];
}
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay bezierPath:(UIBezierPath*)bezierPath options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion{
    [self.layer addKeyframeAnimationWithKeyPath:keyPath duration:duration delay:delay bezierPath:bezierPath options:options completion:completion];
}
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay values:(NSArray*)values options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion{
    [self.layer addKeyframeAnimationWithKeyPath:keyPath duration:duration delay:delay values:values options:options completion:completion];
}

- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay bezierPath:(UIBezierPath*)bezierPath options:(UIViewAnimationOptions)options{
    [self addKeyframeAnimationWithKeyPath:keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay bezierPath:(UIBezierPath*)bezierPath options:(UIViewAnimationOptions)options completion:nil];
}
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay path:(CGPathRef)path options:(UIViewAnimationOptions)options{
    [self addKeyframeAnimationWithKeyPath:keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay path:(CGPathRef)path options:(UIViewAnimationOptions)options completion:nil];
}
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay values:(NSArray*)values options:(UIViewAnimationOptions)options{
    [self  addKeyframeAnimationWithKeyPath:keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay values:(NSArray*)values options:(UIViewAnimationOptions)options completion:nil];
}

#pragma mark CAAnimation Convience Methods
- (void) addAnimation:(CAAnimation*)animation{
    [self addAnimation:animation forKey:nil];
}
- (void) addAnimation:(CAAnimation*)animation completion:(void (^)(BOOL))completion{
    [self.layer addAnimation:animation forKey:nil completion:completion];
}

- (void) addAnimation:(CAAnimation*)animation forKey:(NSString *)key{
    [self addAnimation:animation forKey:key completion:nil];
}
- (void) addAnimation:(CAAnimation*)animation forKey:(NSString *)key completion:(void (^)(BOOL))completion{
    [self.layer addAnimation:animation forKey:key completion:completion];
}

@end




