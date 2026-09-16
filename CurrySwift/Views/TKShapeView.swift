//
//  TKShapeView.swift
//  Created by Devin Ross on 6/24/12.
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


/** This class implements `UIView` backed by a `CAShapeLayer`. */
@objc(TKShapeView)
open class TKShapeView: UIView {
	
	open override class var layerClass: AnyClass { CAShapeLayer.self }
	
	/** The CAShapeLayer object. */
	@objc open var shapeLayer: CAShapeLayer { layer as! CAShapeLayer }
	
	/** The path defining the shape of the view. */
	@objc open var path: CGPath? {
		get { shapeLayer.path }
		set { shapeLayer.path = newValue }
	}
	
	/** The stroke color. */
	@objc open var strokeColor: UIColor? {
		get { shapeLayer.strokeColor.map { UIColor(cgColor: $0) } }
		set { shapeLayer.strokeColor = newValue?.cgColor }
	}
	
	/** The fill color. */
	@objc open var fillColor: UIColor? {
		get { shapeLayer.fillColor.map { UIColor(cgColor: $0) } }
		set { shapeLayer.fillColor = newValue?.cgColor }
	}
	
	/** The stroke's line width. */
	@objc open var lineWidth: CGFloat {
		get { shapeLayer.lineWidth }
		set { shapeLayer.lineWidth = newValue }
	}
	
}
