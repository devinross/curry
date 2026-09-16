//
//  UIGestureRecognizer+Blocks.swift
//  Created by Devin Ross on 4/16/15.
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
import ObjectiveC


/// Only ever used as a unique address for `objc_getAssociatedObject`.
private nonisolated(unsafe) var handlerKey: UInt8 = 0


/** Additional block functionality for `UIGestureRecognizer`. */
extension UIGestureRecognizer {
	
	/** Set the gesture recognizer callback handler. */
	@objc open var handler: ((UIGestureRecognizer) -> Void)? {
		get { objc_getAssociatedObject(self, &handlerKey) as? (UIGestureRecognizer) -> Void }
		set { objc_setAssociatedObject(self, &handlerKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
	}
	
	/** Creates a `UIGestureRecognizer` with a callback handler.
	@param block The callback handler.
	@return A gesture recognizer.
	*/
	@objc(recognizerWithHandler:)
	open class func recognizer(handler block: @escaping (UIGestureRecognizer) -> Void) -> Self {
		let recognizer = self.init()
		recognizer.addTarget(recognizer, action: #selector(handleBlockAction(_:)))
		recognizer.handler = block
		return recognizer
	}
	
	/// Forwards the recognizer's action to its stored block.
	@objc private func handleBlockAction(_ recognizer: UIGestureRecognizer) {
		recognizer.handler?(recognizer)
	}
	
}
