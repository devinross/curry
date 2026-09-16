//
//  UIView+TKCategory.swift
//  Created by Devin Ross on 7/25/09.
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


/** Additional functionality for `UIView`. */
extension UIView {
	
	/** The opposite of hidden. */
	@objc public var visible: Bool {
		get { !isHidden }
		set { isHidden = !newValue }
	}
	
	/** Adds a view to the beginning of the receiver's list of subviews.
	@param view The view to be added. After being added, this view appears below any other subviews.
	*/
	@objc(addSubviewToBack:)
	public func addSubviewToBack(_ view: UIView) {
		insertSubview(view, at: 0)
	}
	
	/** Takes a snapshot of the view.
	@param updates Whether the snapshot is taken after pending screen updates.
	@return The snapshot image.
	*/
	@objc(snapshotImageAfterScreenUpdates:)
	public func snapshotImage(afterScreenUpdates updates: Bool) -> UIImage? {
		let format = UIGraphicsImageRendererFormat.default()
		format.opaque = true
		return UIGraphicsImageRenderer(bounds: bounds, format: format).image { _ in
			drawHierarchy(in: bounds, afterScreenUpdates: updates)
		}
	}
	
	/** Set the shadow for the view.
	@param offset The offset of the shadow.
	@param opacity The opacity of the shadow.
	@param radius The radius of the shadow.
	*/
	@objc(setShadowWithOffset:opacity:radius:)
	public func setShadow(offset: CGSize, opacity: CGFloat, radius: CGFloat) {
		setShadow(offset: offset, opacity: opacity, color: .black, radius: radius)
	}
	
	/** Set the shadow for the view.
	@param offset The offset of the shadow.
	@param opacity The opacity of the shadow.
	@param color The color of the shadow.
	@param radius The radius of the shadow.
	*/
	@objc(setShadowWithOffset:opacity:color:radius:)
	public func setShadow(offset: CGSize, opacity: CGFloat, color: UIColor, radius: CGFloat) {
		setShadow(path: UIBezierPath(rect: bounds), offset: offset, opacity: opacity, color: color, radius: radius)
	}
	
	/** Set the shadow for the view.
	@param bezierPath The shape of the shadow.
	@param offset The shadow offset.
	@param opacity The opacity of the shadow.
	@param color The color of the shadow.
	@param radius The radius of the shadow.
	*/
	@objc(setShadowWithPath:offset:opacity:color:radius:)
	public func setShadow(path bezierPath: UIBezierPath, offset: CGSize, opacity: CGFloat, color: UIColor, radius: CGFloat) {
		layer.shadowPath = bezierPath.cgPath
		layer.shadowOpacity = Float(opacity)
		layer.shadowOffset = offset
		layer.shadowColor = color.cgColor
		layer.shadowRadius = radius
	}
	
	/** Set the border for the view.
	@param color The color of the border.
	@param width The width of the border.
	*/
	@objc(setBorderWithColor:width:)
	public func setBorder(color: UIColor, width: CGFloat) {
		layer.borderColor = color.cgColor
		layer.borderWidth = width
	}
	
	/** The corner radius of the view. */
	@objc public var cornerRadius: CGFloat {
		get { layer.cornerRadius }
		set { layer.cornerRadius = newValue }
	}
	
	/** Removes every gesture recognizer attached to the view. */
	@objc public func removeAllGestureRecognizers() {
		for recognizer in gestureRecognizers ?? [] {
			removeGestureRecognizer(recognizer)
		}
	}
	
	/** Whether the given view appears anywhere above the receiver in the view hierarchy. */
	@objc(hasSuperview:)
	public func hasSuperview(_ parentView: UIView) -> Bool {
		var ancestor = superview
		while let current = ancestor {
			if current === parentView { return true }
			ancestor = current.superview
		}
		return false
	}
	
	/** Removes every motion effect attached to the view. */
	@objc public func removeAllMotionEffects() {
		for effect in motionEffects {
			removeMotionEffect(effect)
		}
	}
	
}
