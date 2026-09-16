//
//  UIImageView+TKCategory.swift
//  Created by Devin Ross on 12/12/10.
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


/** Additional functionality for `UIImageView`. */
extension UIImageView {
	
	/** An image view sized to the named image.
	@param imageName The name of the image in the asset catalog or bundle.
	*/
	@objc(imageViewWithImageNamed:)
	public static func imageView(imageNamed imageName: String) -> Self {
		self.init(image: UIImage(named: imageName))
	}
	
	/** An image view sized to the named image, drawn in the given render mode.
	@param imageName The name of the image in the asset catalog or bundle.
	@param mode The rendering mode applied to the image.
	*/
	@objc(imageViewWithImageNamed:renderMode:)
	public static func imageView(imageNamed imageName: String, renderMode mode: UIImage.RenderingMode) -> Self {
		self.init(image: UIImage(named: imageName)?.withRenderingMode(mode))
	}
	
	/** An image view with the given frame. */
	@objc(imageViewWithFrame:)
	public static func imageView(frame: CGRect) -> Self {
		self.init(frame: frame)
	}
	
	/** Sets `animationImages` from a list of image names.
	@param names The names of the images, in order.
	*/
	@objc(setAnimationImageNames:)
	public func setAnimationImageNames(_ names: [String]) {
		animationImages = names.compactMap { UIImage(named: $0) }
	}
	
}
