//
//  UIView+TKAnimation.swift
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

import UIKit
import QuartzCore


/// The layer key paths the animation helpers are usually driven with.
///
/// These replace the `TKViewAnimationKeyPath*` globals, which Swift cannot
/// export to Objective-C as `extern` constants.
@objc(TKViewAnimationKeyPath)
public final class TKViewAnimationKeyPath: NSObject {
	
	@objc public static let center = "position"
	@objc public static let centerX = "position.x"
	@objc public static let centerY = "position.y"
	@objc public static let transform = "transform"
	@objc public static let frame = "frame"
	@objc public static let origin = "origin"
	@objc public static let originX = "origin.x"
	@objc public static let originY = "origin.y"
	@objc public static let size = "size"
	@objc public static let sizeWidth = "size.width"
	@objc public static let sizeHeight = "size.height"
	
	private override init() { super.init() }
	
}


/** Additional animation functionality for `UIView`. */
extension UIView {
	
	// MARK: - CAAnimation Convenience Methods
	
	/** Add an animation to the view's layer. */
	@objc(addAnimation:)
	public func addAnimation(_ animation: CAAnimation) {
		addAnimation(animation, forKey: nil)
	}
	
	/** Add an animation to the view's layer with a completion block. */
	@objc(addAnimation:completion:)
	public func addAnimation(_ animation: CAAnimation, completion: ((Bool) -> Void)?) {
		layer.addAnimation(animation, forKey: nil, completion: completion)
	}
	
	/** Add an animation to the view's layer under the given key. */
	@objc(addAnimation:forKey:)
	public func addAnimation(_ animation: CAAnimation, forKey key: String?) {
		addAnimation(animation, forKey: key, completion: nil)
	}
	
	/** Add an animation to the view's layer under the given key, with a completion block. */
	@objc(addAnimation:forKey:completion:)
	public func addAnimation(_ animation: CAAnimation, forKey key: String?, completion: ((Bool) -> Void)?) {
		layer.addAnimation(animation, forKey: key, completion: completion)
	}
	
	// MARK: - Keyframe Animations
	
	/** Add a keyframe animation to the view's layer that follows a bezier path. */
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:bezierPath:options:)
	public func addKeyframeAnimation(keyPath: String, duration: CFTimeInterval, delay: CFTimeInterval, bezierPath: UIBezierPath, options: UIView.AnimationOptions) {
		addKeyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, bezierPath: bezierPath, options: options, completion: nil)
	}
	
	/** Add a keyframe animation to the view's layer that follows a bezier path. */
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:bezierPath:options:completion:)
	public func addKeyframeAnimation(keyPath: String, duration: CFTimeInterval, delay: CFTimeInterval, bezierPath: UIBezierPath, options: UIView.AnimationOptions, completion: ((Bool) -> Void)?) {
		layer.addKeyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, bezierPath: bezierPath, options: options, completion: completion)
	}
	
	/** Add a keyframe animation to the view's layer that follows a path. */
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:path:options:)
	public func addKeyframeAnimation(keyPath: String, duration: CFTimeInterval, delay: CFTimeInterval, path: CGPath, options: UIView.AnimationOptions) {
		addKeyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, path: path, options: options, completion: nil)
	}
	
	/** Add a keyframe animation to the view's layer that follows a path. */
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:path:options:completion:)
	public func addKeyframeAnimation(keyPath: String, duration: CFTimeInterval, delay: CFTimeInterval, path: CGPath, options: UIView.AnimationOptions, completion: ((Bool) -> Void)?) {
		layer.addKeyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, path: path, options: options, completion: completion)
	}
	
	/** Add a keyframe animation to the view's layer over a set of values. */
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:values:options:)
	public func addKeyframeAnimation(keyPath: String, duration: CFTimeInterval, delay: CFTimeInterval, values: [Any], options: UIView.AnimationOptions) {
		addKeyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, values: values, options: options, completion: nil)
	}
	
	/** Add a keyframe animation to the view's layer over a set of values. */
	@objc(addKeyframeAnimationWithKeyPath:duration:delay:values:options:completion:)
	public func addKeyframeAnimation(keyPath: String, duration: CFTimeInterval, delay: CFTimeInterval, values: [Any], options: UIView.AnimationOptions, completion: ((Bool) -> Void)?) {
		layer.addKeyframeAnimation(keyPath: keyPath, duration: duration, delay: delay, values: values, options: options, completion: completion)
	}
	
}
