//
//  UIView+Positioning.swift
//  Created by Devin Ross on 4/17/15.
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
	
	/** The receiver's center expressed in another view's coordinate space. */
	@objc(convertCenterToView:)
	public func convertCenter(to view: UIView?) -> CGPoint {
		superview?.convert(center, to: view) ?? center
	}
	
	/** The receiver's frame expressed in another view's coordinate space. */
	@objc(convertFrameToView:)
	public func convertFrame(to view: UIView?) -> CGRect {
		superview?.convert(frame, to: view) ?? frame
	}
	
	/** Moves the receiver into another view, keeping it where it appears on screen. */
	@objc(moveToView:)
	public func move(to view: UIView) {
		center = convertCenter(to: view)
		removeFromSuperview()
		view.addSubview(self)
	}
	
	/** Moves the receiver behind another view's subviews, keeping it where it appears on screen. */
	@objc(moveToBackOfView:)
	public func moveToBack(of view: UIView) {
		center = convertCenter(to: view)
		removeFromSuperview()
		view.addSubviewToBack(self)
	}
	
	/** The midpoint of the receiver's own frame size. */
	@objc public var middle: CGPoint {
		CGPoint(x: frame.width / 2, y: frame.height / 2)
	}
	
	/** The width of the receiver's frame. */
	@objc public var width: CGFloat {
		get { frame.width }
		set { frame.size.width = newValue }
	}
	
	/** The height of the receiver's frame. */
	@objc public var height: CGFloat {
		get { frame.height }
		set { frame.size.height = newValue }
	}
	
	/** The width of the receiver's bounds. */
	@objc public var boundsWidth: CGFloat { bounds.width }
	
	/** The height of the receiver's bounds. */
	@objc public var boundsHeight: CGFloat { bounds.height }
	
	/** The size of the receiver's frame. */
	@objc public var size: CGSize {
		get { frame.size }
		set { frame.size = newValue }
	}
	
	/** The origin of the receiver's frame. */
	@objc public var origin: CGPoint {
		get { frame.origin }
		set { frame.origin = newValue }
	}
	
	/** The left edge of the frame. Setting it moves the view by its center. */
	@objc public var minX: CGFloat {
		get { frame.minX }
		set { center = CGPoint(x: newValue + frame.width / 2, y: center.y) }
	}
	
	/** The top edge of the frame. Setting it moves the view by its center. */
	@objc public var minY: CGFloat {
		get { frame.minY }
		set { center = CGPoint(x: center.x, y: newValue + frame.height / 2) }
	}
	
	/** The horizontal midpoint of the frame. */
	@objc public var midX: CGFloat {
		get { frame.midX }
		set { center = CGPoint(x: newValue, y: center.y) }
	}
	
	/** The vertical midpoint of the frame. */
	@objc public var midY: CGFloat {
		get { frame.midY }
		set { center = CGPoint(x: center.x, y: newValue) }
	}
	
	/** The right edge of the frame. Setting it moves the view by its center. */
	@objc public var maxX: CGFloat {
		get { frame.maxX }
		set { center = CGPoint(x: newValue - frame.width / 2, y: center.y) }
	}
	
	/** The bottom edge of the frame. Setting it moves the view by its center. */
	@objc public var maxY: CGFloat {
		get { frame.maxY }
		set { center = CGPoint(x: center.x, y: newValue - frame.height / 2) }
	}
	
	/** The left edge of the frame. Setting it moves the frame's origin. */
	@objc public var originX: CGFloat {
		get { frame.minX }
		set { frame.origin.x = newValue }
	}
	
	/** The top edge of the frame. Setting it moves the frame's origin. */
	@objc public var originY: CGFloat {
		get { frame.minY }
		set { frame.origin.y = newValue }
	}
	
	/** The horizontal center of the view. */
	@objc public var centerX: CGFloat {
		get { center.x }
		set { center = CGPoint(x: newValue, y: center.y) }
	}
	
	/** The vertical center of the view. */
	@objc public var centerY: CGFloat {
		get { center.y }
		set { center = CGPoint(x: center.x, y: newValue) }
	}
	
}
