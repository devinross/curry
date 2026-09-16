//
//  CAKeyframeAnimation+TKAnimation.swift
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


extension UIView.AnimationOptions {
	
	/// The curve bits of an animation options mask.
	///
	/// `curveEaseInOut` is 0 and `curveLinear` is `curveEaseIn | curveEaseOut`, so the
	/// curve has to be read as a masked value rather than tested bit by bit.
	var timingFunctionName: CAMediaTimingFunctionName {
		let curveMask = UIView.AnimationOptions.curveLinear.rawValue
		switch rawValue & curveMask {
			case UIView.AnimationOptions.curveEaseIn.rawValue:  return .easeIn
			case UIView.AnimationOptions.curveEaseOut.rawValue: return .easeOut
			case UIView.AnimationOptions.curveLinear.rawValue:  return .linear
			default:                                            return .easeInEaseOut
		}
	}
	
	var autoreverses: Bool {
		contains(.autoreverse)
	}
	
}


/** Additional functionality for `CAKeyframeAnimation`. */
extension CAKeyframeAnimation {
	
	/** Create a `CAKeyframeAnimation` animation with the given path.
	@param keyPath The key path of the property to be animated.
	@param duration The duration of the animation.
	@param delay The delay of the animation.
	@param path The path for a point-based property to follow.
	@param options Set the animation curve of the animation.
	*/
	@objc(keyframeAnimationWithKeyPath:duration:delay:path:options:)
	public static func keyframeAnimation(keyPath: String,
	                                     duration: CFTimeInterval,
	                                     delay: CFTimeInterval,
	                                     path: CGPath,
	                                     options: UIView.AnimationOptions) -> CAKeyframeAnimation {
		keyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, path: path, options: options, completion: nil)
	}
	
	/** Create a `CAKeyframeAnimation` animation with the given path.
	@param completion The completion block.
	*/
	@objc(keyframeAnimationWithKeyPath:duration:delay:path:options:completion:)
	public static func keyframeAnimation(keyPath: String,
	                                     duration: CFTimeInterval,
	                                     delay: CFTimeInterval,
	                                     path: CGPath,
	                                     options: UIView.AnimationOptions,
	                                     completion: ((Bool) -> Void)?) -> CAKeyframeAnimation {
		let animation = keyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, options: options, completion: completion)
		animation.path = path
		return animation
	}
	
	/** Create a `CAKeyframeAnimation` animation with the given bezier path. */
	@objc(keyframeAnimationWithKeyPath:duration:delay:bezierPath:options:)
	public static func keyframeAnimation(keyPath: String,
	                                     duration: CFTimeInterval,
	                                     delay: CFTimeInterval,
	                                     bezierPath: UIBezierPath,
	                                     options: UIView.AnimationOptions) -> CAKeyframeAnimation {
		keyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, bezierPath: bezierPath, options: options, completion: nil)
	}
	
	/** Create a `CAKeyframeAnimation` animation with the given bezier path.
	@param completion The completion block.
	*/
	@objc(keyframeAnimationWithKeyPath:duration:delay:bezierPath:options:completion:)
	public static func keyframeAnimation(keyPath: String,
	                                     duration: CFTimeInterval,
	                                     delay: CFTimeInterval,
	                                     bezierPath: UIBezierPath,
	                                     options: UIView.AnimationOptions,
	                                     completion: ((Bool) -> Void)?) -> CAKeyframeAnimation {
		keyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, path: bezierPath.cgPath, options: options, completion: completion)
	}
	
	/** Create a `CAKeyframeAnimation` animation with the given values.
	@param values An array of objects that specify the keyframe values to use for the animation.
	*/
	@objc(keyframeAnimationWithKeyPath:duration:delay:values:options:)
	public static func keyframeAnimation(keyPath: String,
	                                     duration: CFTimeInterval,
	                                     delay: CFTimeInterval,
	                                     values: [Any],
	                                     options: UIView.AnimationOptions) -> CAKeyframeAnimation {
		keyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, values: values, options: options, completion: nil)
	}
	
	/** Create a `CAKeyframeAnimation` animation with the given values.
	@param completion The completion block.
	*/
	@objc(keyframeAnimationWithKeyPath:duration:delay:values:options:completion:)
	public static func keyframeAnimation(keyPath: String,
	                                     duration: CFTimeInterval,
	                                     delay: CFTimeInterval,
	                                     values: [Any],
	                                     options: UIView.AnimationOptions,
	                                     completion: ((Bool) -> Void)?) -> CAKeyframeAnimation {
		let animation = keyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, options: options, completion: completion)
		animation.values = values
		return animation
	}
	
	/** Create a `CAKeyframeAnimation` animation. */
	@objc(keyframeAnimationWithKeyPath:duration:delay:options:)
	public static func keyframeAnimation(keyPath: String,
	                                     duration: CFTimeInterval,
	                                     delay: CFTimeInterval,
	                                     options: UIView.AnimationOptions) -> CAKeyframeAnimation {
		keyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, options: options, completion: nil)
	}
	
	/** Create a `CAKeyframeAnimation` animation.
	@param completion The completion block.
	*/
	@objc(keyframeAnimationWithKeyPath:duration:delay:options:completion:)
	public static func keyframeAnimation(keyPath: String,
	                                     duration: CFTimeInterval,
	                                     delay: CFTimeInterval,
	                                     options: UIView.AnimationOptions,
	                                     completion: ((Bool) -> Void)?) -> CAKeyframeAnimation {
		
		let animation = CAKeyframeAnimation(keyPath: keyPath)
		animation.autoreverses = options.autoreverses
		animation.duration = duration
		
		if delay != 0.0 {
			animation.beginTime = CACurrentMediaTime() + delay
		}
		
		animation.timingFunction = CAMediaTimingFunction(name: options.timingFunctionName)
		
		if let completion {
			animation.completion = completion
		}
		
		return animation
	}
	
}
