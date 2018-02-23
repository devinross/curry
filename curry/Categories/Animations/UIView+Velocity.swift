//
//  UIView+Velocity.swift
//  Created by Devin Ross on 2/22/18.
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

extension UIView {
	
	
	@available(iOS 10.0, *)
	@discardableResult @objc public class func animate(withDuration: TimeInterval, dampingRatio: CGFloat, initialVelocity:CGVector, animations: @escaping (()->Void), completion: ((UIViewAnimatingPosition) -> Swift.Void)?) -> UIViewPropertyAnimator {

		let animator = UIViewPropertyAnimator(duration: withDuration, dampingRatio: dampingRatio, animations: animations)

		if let com = completion {
			animator.addCompletion(com)
		}
		
		let spring = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
		animator.continueAnimation(withTimingParameters: spring, durationFactor: 1)
		animator.startAnimation()
		return animator
		
	}
	
}
