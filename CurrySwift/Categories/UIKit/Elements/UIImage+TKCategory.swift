//
//  UIImage+TKCategory.swift
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
import Accelerate


/** Additional functionality for `UIImage`. */
extension UIImage {
	
	/** Crops the image to the given rect, in pixels. */
	@objc(imageCroppedToRect:)
	open func imageCropped(to rect: CGRect) -> UIImage? {
		guard let cropped = cgImage?.cropping(to: rect) else { return nil }
		return UIImage(cgImage: cropped)
	}
	
	/** The image cropped to a square anchored at its top left corner. */
	@objc open var imageByApplyingSquareCrop: UIImage? {
		let side = min(size.width, size.height)
		return imageCropped(to: CGRect(x: 0, y: 0, width: side * scale, height: side * scale))
	}
	
	/** The image cropped to a square at its center. */
	@objc open var imageByApplyingCenteredSquareCrop: UIImage? {
		let side = min(size.width, size.height)
		let originX = ((size.width - side) / 2).rounded()
		let originY = ((size.height - side) / 2).rounded()
		return imageCropped(to: CGRect(x: originX * scale, y: originY * scale, width: side * scale, height: side * scale))
	}
	
	/** A light, translucent blur over the image. */
	@objc open var imageByApplyingLightEffect: UIImage? {
		imageByApplyingBlur(radius: 30,
		                    tintColor: UIColor(white: 1.0, alpha: 0.3),
		                    saturationDeltaFactor: 1.8,
		                    maskImage: nil)
	}
	
	/** An extra light, translucent blur over the image. */
	@objc open var imageByApplyingExtraLightEffect: UIImage? {
		imageByApplyingBlur(radius: 20,
		                    tintColor: UIColor(white: 0.97, alpha: 0.82),
		                    saturationDeltaFactor: 1.8,
		                    maskImage: nil)
	}
	
	/** A dark, translucent blur over the image.
	@param blurRadius The radius of the blur.
	@param saturation The saturation delta applied alongside the blur.
	*/
	@objc(imageByApplyingDarkEffectWithBlurRadius:saturationFactor:)
	open func imageByApplyingDarkEffect(blurRadius: CGFloat, saturationFactor saturation: CGFloat) -> UIImage? {
		imageByApplyingBlur(radius: blurRadius,
		                    tintColor: UIColor(white: 0.11, alpha: 0.63),
		                    saturationDeltaFactor: saturation,
		                    maskImage: nil)
	}
	
	/** A dark, translucent blur over the image. */
	@objc open var imageByApplyingDarkEffect: UIImage? {
		imageByApplyingBlur(radius: 20,
		                    tintColor: UIColor(white: 0.11, alpha: 0.73),
		                    saturationDeltaFactor: 1.8,
		                    maskImage: nil)
	}
	
	/** A blur tinted with the given color.
	@param tintColor The color the blur is tinted with.
	*/
	@objc(imageByApplyingTintEffectWithColor:)
	open func imageByApplyingTintEffect(color tintColor: UIColor) -> UIImage? {
		
		let effectColorAlpha: CGFloat = 0.6
		var effectColor = tintColor
		
		if tintColor.cgColor.numberOfComponents == 2 {
			var white: CGFloat = 0
			if tintColor.getWhite(&white, alpha: nil) {
				effectColor = UIColor(white: white, alpha: effectColorAlpha)
			}
		} else {
			var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
			if tintColor.getRed(&red, green: &green, blue: &blue, alpha: nil) {
				effectColor = UIColor(red: red, green: green, blue: blue, alpha: effectColorAlpha)
			}
		}
		
		return imageByApplyingBlur(radius: 10, tintColor: effectColor, saturationDeltaFactor: -1.0, maskImage: nil)
	}
	
	/** Blurs, saturates, masks and tints the image in one pass.
	@param blurRadius The radius of the gaussian blur approximation.
	@param tintColor A color filled over the result.
	@param saturationDeltaFactor 1.0 leaves saturation untouched.
	@param maskImage Restricts where the blurred image is drawn.
	*/
	@objc(imageByApplyingBlurWithRadius:tintColor:saturationDeltaFactor:maskImage:)
	open func imageByApplyingBlur(radius blurRadius: CGFloat,
	                                tintColor: UIColor?,
	                                saturationDeltaFactor: CGFloat,
	                                maskImage: UIImage?) -> UIImage? {
		
		// Check pre-conditions.
		guard size.width >= 1, size.height >= 1 else {
			NSLog("*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", size.width, size.height, self)
			return nil
		}
		guard let selfCGImage = cgImage else {
			NSLog("*** error: image must be backed by a CGImage: %@", self)
			return nil
		}
		if let maskImage, maskImage.cgImage == nil {
			NSLog("*** error: maskImage must be backed by a CGImage: %@", maskImage)
			return nil
		}
		
		let imageRect = CGRect(origin: .zero, size: size)
		var effectImage = self
		
		let screenScale = UIScreen.main.scale
		let epsilon = CGFloat(Float.ulpOfOne)
		let hasBlur = blurRadius > epsilon
		let hasSaturationChange = abs(saturationDeltaFactor - 1.0) > epsilon
		
		if hasBlur || hasSaturationChange {
			
			UIGraphicsBeginImageContextWithOptions(size, false, screenScale)
			guard let effectInContext = UIGraphicsGetCurrentContext() else {
				UIGraphicsEndImageContext()
				return nil
			}
			effectInContext.scaleBy(x: 1.0, y: -1.0)
			effectInContext.translateBy(x: 0, y: -size.height)
			effectInContext.draw(selfCGImage, in: imageRect)
			
			var effectInBuffer = vImage_Buffer(data: effectInContext.data,
			                                   height: vImagePixelCount(effectInContext.height),
			                                   width: vImagePixelCount(effectInContext.width),
			                                   rowBytes: effectInContext.bytesPerRow)
			
			UIGraphicsBeginImageContextWithOptions(size, false, screenScale)
			guard let effectOutContext = UIGraphicsGetCurrentContext() else {
				UIGraphicsEndImageContext()
				UIGraphicsEndImageContext()
				return nil
			}
			var effectOutBuffer = vImage_Buffer(data: effectOutContext.data,
			                                    height: vImagePixelCount(effectOutContext.height),
			                                    width: vImagePixelCount(effectOutContext.width),
			                                    rowBytes: effectOutContext.bytesPerRow)
			
			if hasBlur {
				// A description of how to compute the box kernel width from the Gaussian
				// radius (aka standard deviation) appears in the SVG spec:
				// http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
				//
				// For larger values of 's' (s >= 2.0), an approximation can be used: Three
				// successive box-blurs build a piece-wise quadratic convolution kernel, which
				// approximates the Gaussian kernel to within roughly 3%.
				//
				// let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
				//
				// ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
				let inputRadius = blurRadius * screenScale
				var radius = UInt32(floor(inputRadius * 3.0 * CGFloat((2 * Double.pi).squareRoot()) / 4 + 0.5))
				if radius % 2 != 1 {
					radius += 1 // force radius to be odd so that the three box-blur methodology works.
				}
				let flags = vImage_Flags(kvImageEdgeExtend)
				vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, flags)
				vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, nil, 0, 0, radius, radius, nil, flags)
				vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, flags)
			}
			
			var effectImageBuffersAreSwapped = false
			
			if hasSaturationChange {
				let s = saturationDeltaFactor
				let floatingPointSaturationMatrix: [CGFloat] = [
					0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
					0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
					0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
					0,                    0,                    0,                    1,
				]
				let divisor: Int32 = 256
				let saturationMatrix = floatingPointSaturationMatrix.map { Int16(($0 * CGFloat(divisor)).rounded()) }
				
				if hasBlur {
					vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, nil, nil, vImage_Flags(kvImageNoFlags))
					effectImageBuffersAreSwapped = true
				} else {
					vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, nil, nil, vImage_Flags(kvImageNoFlags))
				}
			}
			
			// The result sits in whichever buffer was written last, and each buffer belongs
			// to its own context, so the image is taken before that context is popped.
			if !effectImageBuffersAreSwapped, let image = UIGraphicsGetImageFromCurrentImageContext() {
				effectImage = image
			}
			UIGraphicsEndImageContext()
			
			if effectImageBuffersAreSwapped, let image = UIGraphicsGetImageFromCurrentImageContext() {
				effectImage = image
			}
			UIGraphicsEndImageContext()
		}
		
		// Set up output context.
		UIGraphicsBeginImageContextWithOptions(size, false, screenScale)
		guard let outputContext = UIGraphicsGetCurrentContext() else {
			UIGraphicsEndImageContext()
			return nil
		}
		outputContext.scaleBy(x: 1.0, y: -1.0)
		outputContext.translateBy(x: 0, y: -size.height)
		
		// Draw base image.
		outputContext.draw(selfCGImage, in: imageRect)
		
		// Draw effect image.
		if hasBlur, let effectCGImage = effectImage.cgImage {
			outputContext.saveGState()
			if let mask = maskImage?.cgImage {
				outputContext.clip(to: imageRect, mask: mask)
			}
			outputContext.draw(effectCGImage, in: imageRect)
			outputContext.restoreGState()
		}
		
		// Add in color tint.
		if let tintColor {
			outputContext.saveGState()
			outputContext.setFillColor(tintColor.cgColor)
			outputContext.fill(imageRect)
			outputContext.restoreGState()
		}
		
		// Output image is ready.
		let outputImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return outputImage
	}
	
}
