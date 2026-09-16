//
//  TKUIKit.swift
//  Created by Devin Ross on 9/21/15.
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


// Thin conveniences over CoreGraphics and QuartzCore, carried over from the
// Objective-C TKUIKit.h. They were C inline functions there, so they are Swift
// functions here and are no longer reachable from Objective-C.

// MARK: - Transforms

public func CAScale(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) -> CATransform3D {
	CATransform3DMakeScale(x, y, z)
}

public func CARotate(_ angle: CGFloat, _ x: CGFloat, _ y: CGFloat, _ z: CGFloat) -> CATransform3D {
	CATransform3DMakeRotation(angle, x, y, z)
}

public func CATranslate(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) -> CATransform3D {
	CATransform3DMakeTranslation(x, y, z)
}

public func CAConcat(_ t1: CATransform3D, _ t2: CATransform3D) -> CATransform3D {
	CATransform3DConcat(t1, t2)
}

public func CGScale(_ x: CGFloat, _ y: CGFloat) -> CGAffineTransform {
	CGAffineTransform(scaleX: x, y: y)
}

public func CGRotate(_ angle: CGFloat) -> CGAffineTransform {
	CGAffineTransform(rotationAngle: angle)
}

public func CGTranslate(_ x: CGFloat, _ y: CGFloat) -> CGAffineTransform {
	CGAffineTransform(translationX: x, y: y)
}

public func CGConcat(_ first: CGAffineTransform, _ second: CGAffineTransform) -> CGAffineTransform {
	first.concatenating(second)
}

// MARK: - Rects

public func CGRectMakeWithSize(_ x: CGFloat, _ y: CGFloat, _ size: CGSize) -> CGRect {
	CGRect(origin: CGPoint(x: x, y: y), size: size)
}

public func CGRectMakeWithPoint(_ origin: CGPoint, _ width: CGFloat, _ height: CGFloat) -> CGRect {
	CGRect(origin: origin, size: CGSize(width: width, height: height))
}

public func CGRectCompose(_ origin: CGPoint, _ size: CGSize) -> CGRect {
	CGRect(origin: origin, size: size)
}

public func CGRectMakeInset(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat,
                            _ dx: CGFloat, _ dy: CGFloat) -> CGRect {
	CGRect(x: x, y: y, width: width, height: height).insetBy(dx: dx, dy: dy)
}

public func CGRectInsetX(_ rect: CGRect, _ dx: CGFloat) -> CGRect {
	rect.insetBy(dx: dx, dy: 0)
}

public func CGRectInsetY(_ rect: CGRect, _ dy: CGFloat) -> CGRect {
	rect.insetBy(dx: 0, dy: dy)
}

public func CGRectCenteredInRect(_ parentRect: CGRect, _ width: CGFloat, _ height: CGFloat) -> CGRect {
	CGRectCenteredInRectWithSize(parentRect, CGSize(width: width, height: height))
}

public func CGRectCenteredInRectWithSize(_ parentRect: CGRect, _ size: CGSize) -> CGRect {
	CGRect(x: ((parentRect.width - size.width) / 2).rounded(.down),
	       y: ((parentRect.height - size.height) / 2).rounded(.down),
	       width: size.width, height: size.height)
}

public func CGRectCenteredXInRect(_ parentRect: CGRect, _ originY: CGFloat,
                                  _ width: CGFloat, _ height: CGFloat) -> CGRect {
	CGRectCenteredXInRectWithSize(parentRect, originY, CGSize(width: width, height: height))
}

public func CGRectCenteredXInRectWithSize(_ parentRect: CGRect, _ originY: CGFloat, _ size: CGSize) -> CGRect {
	CGRect(x: ((parentRect.width - size.width) / 2).rounded(.down), y: originY,
	       width: size.width, height: size.height)
}

public func CGRectCenteredYInRect(_ parentRect: CGRect, _ originX: CGFloat,
                                  _ width: CGFloat, _ height: CGFloat) -> CGRect {
	CGRectCenteredYInRectWithSize(parentRect, originX, CGSize(width: width, height: height))
}

public func CGRectCenteredYInRectWithSize(_ parentRect: CGRect, _ originX: CGFloat, _ size: CGSize) -> CGRect {
	CGRect(x: originX, y: ((parentRect.height - size.height) / 2).rounded(.down),
	       width: size.width, height: size.height)
}

// MARK: - Points

public func CGPointGetMidpoint(_ p1: CGPoint, _ p2: CGPoint) -> CGPoint {
	CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
}

public func CGPointGetDistance(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
	let dx = p2.x - p1.x, dy = p2.y - p1.y
	return (dx * dx + dy * dy).squareRoot()
}

public func CGRectGetMidpoint(_ rect: CGRect) -> CGPoint {
	CGPoint(x: rect.midX, y: rect.midY)
}

public func CGRectGetCenter(_ rect: CGRect) -> CGPoint {
	CGPoint(x: rect.midX, y: rect.midY)
}

// MARK: - View frames

public func CGFrameGetWidth(_ view: UIView) -> CGFloat  { view.frame.width }
public func CGFrameGetHeight(_ view: UIView) -> CGFloat { view.frame.height }
public func CGBoundsGetWidth(_ view: UIView) -> CGFloat  { view.bounds.width }
public func CGBoundsGetHeight(_ view: UIView) -> CGFloat { view.bounds.height }
public func CGFrameGetMinX(_ view: UIView) -> CGFloat { view.frame.minX }
public func CGFrameGetMinY(_ view: UIView) -> CGFloat { view.frame.minY }
public func CGFrameGetMaxX(_ view: UIView) -> CGFloat { view.frame.maxX }
public func CGFrameGetMaxY(_ view: UIView) -> CGFloat { view.frame.maxY }
public func CGFrameGetMidX(_ view: UIView) -> CGFloat { view.frame.midX }
public func CGFrameGetMidY(_ view: UIView) -> CGFloat { view.frame.midY }
