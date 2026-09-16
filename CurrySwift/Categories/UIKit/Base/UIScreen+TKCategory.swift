//
//  UIScreen+TKCategory.swift
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

import UIKit


/** Additional functionality for `UIScreen`. */
extension UIScreen {
	
	/** The point size of one pixel on screen. (ie. @1x => 1, @2x => 0.5) */
	@objc public var onePixelSize: CGFloat { 1.0 / scale }
	
	#if !os(tvOS)
	
	/** Animate the screen brightness change.
	@param brightness The brightness (from 0.0 to 1.0) the screen should illuminate to.
	@param animated Animate the screen brightness change.
	*/
	@objc(setBrightness:animated:)
	public func setBrightness(_ target: CGFloat, animated: Bool) {
		
		if target == brightness { return }
		
		guard animated else {
			brightness = target
			return
		}
		
		NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(adjustBrightness(_:)), object: nil)
		perform(#selector(adjustBrightness(_:)), with: NSNumber(value: Double(target)), afterDelay: 0.01)
	}
	
	/// Steps the brightness one notch toward the goal, rescheduling itself until it arrives.
	@objc private func adjustBrightness(_ sender: NSNumber) {
		
		let goal = CGFloat(sender.doubleValue)
		if abs(brightness - goal) < 0.01 { return }
		
		brightness += goal > brightness ? 0.01 : -0.01
		
		NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(adjustBrightness(_:)), object: nil)
		perform(#selector(adjustBrightness(_:)), with: sender, afterDelay: 0.01)
	}
	
	#endif
	
}
