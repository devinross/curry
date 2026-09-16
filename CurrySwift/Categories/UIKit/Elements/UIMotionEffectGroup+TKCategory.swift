//
//  UIMotionEffectGroup+TKCategory.swift
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

import UIKit


extension UIMotionEffectGroup {
	
	/** A parallax effect that both tilts and shifts the view as the device moves.
	@param xAngle Degrees of rotation about the vertical axis.
	@param yAngle Degrees of rotation about the horizontal axis.
	@param xMove Points of horizontal movement.
	@param yMove Points of vertical movement.
	*/
	@objc(parallaxMotionEffectGroupWithXAngle:yAngle:xMove:yMove:)
	open class func parallaxMotionEffectGroup(xAngle: CGFloat, yAngle: CGFloat, xMove: CGFloat, yMove: CGFloat) -> UIMotionEffectGroup {
		
		let xRot = UIInterpolatingMotionEffect(keyPath: "layer.transform", type: .tiltAlongHorizontalAxis)
		let yRot = UIInterpolatingMotionEffect(keyPath: "layer.transform", type: .tiltAlongVerticalAxis)
		let xMov = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
		let yMov = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
		
		xMov.minimumRelativeValue = -xMove
		xMov.maximumRelativeValue = xMove
		yMov.minimumRelativeValue = -yMove
		yMov.maximumRelativeValue = yMove
		
		var base = CATransform3DIdentity
		base.m34 = 1.0 / 1000
		
		let radians = { (degrees: CGFloat) in degrees * .pi / 180.0 }
		
		yRot.minimumRelativeValue = NSValue(caTransform3D: CATransform3DRotate(base, radians(yAngle), 1, 0, 0))
		yRot.maximumRelativeValue = NSValue(caTransform3D: CATransform3DRotate(base, radians(yAngle), -1, 0, 0))
		
		xRot.minimumRelativeValue = NSValue(caTransform3D: CATransform3DRotate(base, radians(xAngle), 0, -1, 0))
		xRot.maximumRelativeValue = NSValue(caTransform3D: CATransform3DRotate(base, radians(xAngle), 0, 1, 0))
		
		let group = UIMotionEffectGroup()
		group.motionEffects = [xMov, yMov, yRot, xRot]
		return group
	}
	
}
