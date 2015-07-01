//
//  CAKeyframeAnimation+TKAnimation.h
//  Created by Devin Ross on 2/9/15.
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

/** Additional functionality for `CAKeyframeAnimation`.  */
@interface CAKeyframeAnimation (TKAnimation)

/** Create a `CAKeyframeAnimation` animation with the given path.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param path The path for a point-based property to follow.
 @param options Set the animaiton curve of the animation.
 */
+ (CAKeyframeAnimation*) keyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay path:(CGPathRef)path options:(UIViewAnimationOptions)options;

/** Create a `CAKeyframeAnimation` animation with the given path.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param path The path for a point-based property to follow.
 @param options Set the animaiton curve of the animation.
 @param completion The completion block.
 */
+ (CAKeyframeAnimation*) keyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay path:(CGPathRef)path options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion;


/** Create a `CAKeyframeAnimation` animation with the given path.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param bezierPath The path for a point-based property to follow.
 @param options Set the animaiton curve of the animation.
 */
+ (CAKeyframeAnimation*) keyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay bezierPath:(UIBezierPath*)bezierPath options:(UIViewAnimationOptions)options;


/** Create a `CAKeyframeAnimation` animation with the given path.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param bezierPath The path for a point-based property to follow.
 @param options Set the animaiton curve of the animation.
 @param completion The completion block.
 */
+ (CAKeyframeAnimation*) keyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay bezierPath:(UIBezierPath*)bezierPath options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion;


/** Create a `CAKeyframeAnimation` animation with the given path.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param values An array of objects that specify the keyframe values to use for the animation.
 @param options Set the animaiton curve of the animation.
 */
+ (CAKeyframeAnimation*) keyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay values:(NSArray*)values options:(UIViewAnimationOptions)options;


/** Create a `CAKeyframeAnimation` animation with the given path.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param values An array of objects that specify the keyframe values to use for the animation.
 @param options Set the animaiton curve of the animation.
 @param completion The completion block.
 */
+ (CAKeyframeAnimation*) keyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay values:(NSArray*)values options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion;

/** Create a `CAKeyframeAnimation` animation with the given path.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param options Set the animaiton curve of the animation.
 */
+ (CAKeyframeAnimation*) keyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay options:(UIViewAnimationOptions)options;

/** Create a `CAKeyframeAnimation` animation with the given path.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param options Set the animaiton curve of the animation.
 @param completion The completion block.
 */
+ (CAKeyframeAnimation*) keyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion;

@end