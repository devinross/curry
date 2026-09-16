//
//  CALayer+TKAnimation.swift
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

import UIKit
import QuartzCore


/** Additional functionality for `CALayer`. */
extension CALayer {
	
	/** Add an animation with a completion block.
	@param animation The animation to add.
	@param key The key the animation is stored under.
	@param completion The block executed when the animation is complete.
	*/
	@objc(addAnimation:forKey:completion:)
	public func addAnimation(_ animation: CAAnimation, forKey key: String?, completion: ((Bool) -> Void)?) {
		if let completion {
			animation.completion = completion
		}
		add(animation, forKey: key)
	}
	
	/** Add an animation with a completion block.
	@param animation The animation to add.
	@param completion The block executed when the animation is complete.
	*/
	@objc(addAnimation:completion:)
	public func addAnimation(_ animation: CAAnimation, completion: ((Bool) -> Void)?) {
		addAnimation(animation, forKey: nil, completion: completion)
	}
	
	// MARK: - Keyframe Animations
	
	/** Add a keyframe animation that follows a path. */
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:path:options:)
	public func addKeyframeAnimation(keyPath: String,
	                                 duration: CFTimeInterval,
	                                 delay: CFTimeInterval,
	                                 path: CGPath,
	                                 options: UIView.AnimationOptions) {
		addKeyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, path: path, options: options, completion: nil)
	}
	
	/** Add a keyframe animation that follows a path.
	@param completion The completion block.
	*/
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:path:options:completion:)
	public func addKeyframeAnimation(keyPath: String,
	                                 duration: CFTimeInterval,
	                                 delay: CFTimeInterval,
	                                 path: CGPath,
	                                 options: UIView.AnimationOptions,
	                                 completion: ((Bool) -> Void)?) {
		let animation = CAKeyframeAnimation.keyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, path: path, options: options, completion: completion)
		animation.isRemovedOnCompletion = true
		animation.fillMode = .both
		add(animation, forKey: nil)
	}
	
	/** Add a keyframe animation that follows a bezier path. */
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:bezierPath:options:)
	public func addKeyframeAnimation(keyPath: String,
	                                 duration: CFTimeInterval,
	                                 delay: CFTimeInterval,
	                                 bezierPath: UIBezierPath,
	                                 options: UIView.AnimationOptions) {
		addKeyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, bezierPath: bezierPath, options: options, completion: nil)
	}
	
	/** Add a keyframe animation that follows a bezier path.
	@param completion The completion block.
	*/
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:bezierPath:options:completion:)
	public func addKeyframeAnimation(keyPath: String,
	                                 duration: CFTimeInterval,
	                                 delay: CFTimeInterval,
	                                 bezierPath: UIBezierPath,
	                                 options: UIView.AnimationOptions,
	                                 completion: ((Bool) -> Void)?) {
		addKeyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, path: bezierPath.cgPath, options: options, completion: completion)
	}
	
	/** Add a keyframe animation over a set of values. */
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:values:options:)
	public func addKeyframeAnimation(keyPath: String,
	                                 duration: CFTimeInterval,
	                                 delay: CFTimeInterval,
	                                 values: [Any],
	                                 options: UIView.AnimationOptions) {
		addKeyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, values: values, options: options, completion: nil)
	}
	
	/** Add a keyframe animation over a set of values.
	@param completion The completion block.
	*/
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:values:options:completion:)
	public func addKeyframeAnimation(keyPath: String,
	                                 duration: CFTimeInterval,
	                                 delay: CFTimeInterval,
	                                 values: [Any],
	                                 options: UIView.AnimationOptions,
	                                 completion: ((Bool) -> Void)?) {
		let animation = CAKeyframeAnimation.keyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, values: values, options: options, completion: completion)
		animation.isRemovedOnCompletion = true
		animation.fillMode = .both
		add(animation, forKey: nil)
	}
	
}
