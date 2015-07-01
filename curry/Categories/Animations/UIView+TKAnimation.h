//
//  UIView+TKAnimation.h
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

@import UIKit;
@import QuartzCore;

extern NSString *TKViewAnimationKeyPathCenter;
extern NSString *TKViewAnimationKeyPathFrame;
extern NSString *TKViewAnimationKeyPathOrigin;
extern NSString *TKViewAnimationKeyPathOriginX;
extern NSString *TKViewAnimationKeyPathOriginY;
extern NSString *TKViewAnimationKeyPathSize;
extern NSString *TKViewAnimationKeyPathSizeWidth;
extern NSString *TKViewAnimationKeyPathSizeHeight;
extern NSString *TKViewAnimationKeyPathTransform;

/** Additional animation functionality for `UIView`. */
@interface UIView (TKAnimation)

/** Add an animation to the view.
 @param animation The animation object to be added.
 */
- (void) addAnimation:(CAAnimation*)animation;

/** Adds an animation object with a completion block.
 @param animation The animation object to be added.
 @param completion The block called upon completion.
 */
- (void) addAnimation:(CAAnimation*)animation completion:(void (^)(BOOL))completion;

/** Adds an animation object with a completion block.
 @param animation The animation object to be added.
 @param key An string identifying the animation for later retrieval. You may pass nil if you don’t need to reference the animation later.
 */
- (void) addAnimation:(CAAnimation*)animation forKey:(NSString *)key;

/** Adds an animation object with a completion block for the specified key.
 @param animation The animation object to be added.
 @param key An string identifying the animation for later retrieval. You may pass nil if you don’t need to reference the animation later.
 @param completion The block called upon completion.
 */
- (void) addAnimation:(CAAnimation*)animation forKey:(NSString *)key completion:(void (^)(BOOL))completion;

/** Adds a keyframe animation object with a completion block for the specified key.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param bezierPath The path for a point-based property to follow.
 @param options Set the animaiton curve of the animation.
 */
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay bezierPath:(UIBezierPath*)bezierPath options:(UIViewAnimationOptions)options;

/** Adds a keyframe animation object with a completion block for the specified key.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param bezierPath The path for a point-based property to follow.
 @param options Set the animaiton curve of the animation.
 @param completion The completion block.
 */
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay bezierPath:(UIBezierPath*)bezierPath options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion;

/** Adds a keyframe animation object with a completion block for the specified key.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param path The path for a point-based property to follow.
 @param options Set the animaiton curve of the animation.
 */
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay path:(CGPathRef)path options:(UIViewAnimationOptions)options;

/** Adds a keyframe animation object with a completion block for the specified key.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param path The path for a point-based property to follow.
 @param options Set the animaiton curve of the animation.
 @param completion The completion block.
 */
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay path:(CGPathRef)path options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion;

/** Adds a keyframe animation object with a completion block for the specified key.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param values An array of objects that specify the keyframe values to use for the animation.
 @param options Set the animaiton curve of the animation.
 */
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay values:(NSArray*)values options:(UIViewAnimationOptions)options;


/** Adds a keyframe animation object with a completion block for the specified key.
 @param keyPath The key path of the property to be animated.
 @param duration The duration of the animation.
 @param delay The delay of the animation.
 @param values An array of objects that specify the keyframe values to use for the animation.
 @param options Set the animaiton curve of the animation.
 @param completion The completion block.
 */
- (void) addKeyframeAnimationWithKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay values:(NSArray*)values options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion;


@end

