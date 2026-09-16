//
//  CAAnimation+TKAnimation.swift
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

import QuartzCore


/// Holds the blocks and forwards the delegate callbacks. Named to avoid colliding
/// with QuartzCore's own `CAAnimationDelegate` protocol.
private final class TKCAAnimationDelegate: NSObject, CAAnimationDelegate {
	
	var completion: ((Bool) -> Void)?
	var start: (() -> Void)?
	
	func animationDidStart(_ anim: CAAnimation) {
		start?()
	}
	
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		completion?(flag)
	}
	
}


/** Additional functionality for `CAAnimation`. */
extension CAAnimation {
	
	/** The callback block executed when the animation completes. */
	@objc open var completion: ((Bool) -> Void)? {
		get { (delegate as? TKCAAnimationDelegate)?.completion }
		set { blockDelegate().completion = newValue }
	}
	
	/** A callback block executed when the animation starts. */
	@objc open var start: (() -> Void)? {
		get { (delegate as? TKCAAnimationDelegate)?.start }
		set { blockDelegate().start = newValue }
	}
	
	/// The block-forwarding delegate, installing one if the animation has none.
	private func blockDelegate() -> TKCAAnimationDelegate {
		if let existing = delegate as? TKCAAnimationDelegate { return existing }
		let installed = TKCAAnimationDelegate()
		delegate = installed
		return installed
	}
	
}
