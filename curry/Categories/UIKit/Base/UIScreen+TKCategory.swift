//  Converted to Swift 5.3 by Swiftify v5.3.29144 - https://swiftify.com/
//
//  UIScreen+TKCategory.m
//  Created by Devin Ross on 8/31/13.
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

/// Additional functionality for `UIScreen`.
extension UIScreen {
	
	/// The point size of one pixel on screen. (ie. @1x => 1, @2x => 0.5)
	public func onePixelSize() -> CGFloat {
        return 1.0 / scale
    }

#if !os(tvOS)
	
	/// Animate the screen brightness change.
	/// - Parameters:
	///   - brightness: The brightness (from 0.0 to 1.0) the screen should illuminate to.
	///   - animated: Animate the screen brightness change.
	@objc public func setBrightness(_ brightness: CGFloat, animated: Bool) {
        if brightness == self.brightness {
            return
        }

        if !animated {
            self.brightness = brightness
            return
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(adjustBrightness(_:)), object: nil)
        perform(#selector(adjustBrightness(_:)), with: NSNumber(value: Float(brightness)), afterDelay: 0.01)
    }


    @objc public func adjustBrightness(_ sender: NSNumber?) {
        let brightness = self.brightness
        let goalBrightness = CGFloat(sender?.doubleValue ?? 0.0)
        if abs(Float(brightness - goalBrightness)) < 0.01 {
            return
        }
        let goUp = goalBrightness > brightness
        self.brightness += goUp ? 0.01 : -0.01
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(adjustBrightness(_:)), object: nil)
        perform(#selector(adjustBrightness(_:)), with: sender, afterDelay: 0.01)
    }
#endif
}
