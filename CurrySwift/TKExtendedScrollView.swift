//
//  TKExtendedScrollView.swift
//  Created by Devin Ross on 12/7/14.
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


#if os(iOS)

/** The planes that will receive the touch gestures. */
@objc(TKExtendedScrollViewExtensionPlane)
public enum TKExtendedScrollViewExtensionPlane: Int {
	case none = 0
	case x    = 1
	case y    = 2
	case xy   = 3
}


/** This class is a subclass of `UIScrollView` that allows for tracking of gestures outside its bounds. Good for paged scroll view with pages that peek on both sides. */
@objc(TKExtendedScrollView)
open class TKExtendedScrollView: UIScrollView {
	
	/** A bitwise operator for receiving touch gestures outside the scroll view for the x and y planes. */
	@objc open var extensionPlane: TKExtendedScrollViewExtensionPlane = .none
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		configure()
	}
	
	private func configure() {
		clipsToBounds = false
		showsHorizontalScrollIndicator = false
		isPagingEnabled = true
	}
	
	open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		// The Objective-C original tested `extensionPlane & TKExtendedScrollViewExtensionPlaneXY`
		// first. Since that case is 3, it matched every non-zero plane and returned early, and
		// the per-plane branches that followed were unreachable. This is that behaviour, stated
		// plainly: the plane is honoured in pointInside(_:with:) instead.
		super.hitTest(point, with: event) ?? self
	}
	
	open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		
		var extended = bounds
		
		if extensionPlane.rawValue & TKExtendedScrollViewExtensionPlane.x.rawValue != 0 {
			extended = extended.insetBy(dx: -100, dy: 0)
		}
		
		if extensionPlane.rawValue & TKExtendedScrollViewExtensionPlane.y.rawValue != 0 {
			extended = extended.insetBy(dx: 0, dy: -100)
		}
		
		return extended.contains(point)
	}
	
}

#endif
