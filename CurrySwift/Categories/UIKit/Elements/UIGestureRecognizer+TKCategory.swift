//
//  UIGestureRecognizer+TKCategory.swift
//  Created by Devin Ross on 7/25/13.
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


/** Additional functionality for `UIGestureRecognizer`. */
extension UIGestureRecognizer {
	
	/** Returns YES if the gesture recognizer state is `began`, otherwise NO. */
	@objc open var began: Bool { state == .began }
	
	/** Returns YES if the gesture recognizer state is `changed`, otherwise NO. */
	@objc open var changed: Bool { state == .changed }
	
	/** Returns YES if the gesture recognizer state is `ended`, otherwise NO. */
	@objc open var ended: Bool { state == .ended }
	
	/** Returns YES if the gesture recognizer state is `cancelled`, otherwise NO. */
	@objc open var cancelled: Bool { state == .cancelled }
	
	/** Returns YES if the gesture recognizer state is `failed`, otherwise NO. */
	@objc open var failed: Bool { state == .failed }
	
	/** Returns YES if the gesture recognizer state is `possible`, otherwise NO. */
	@objc open var possible: Bool { state == .possible }
	
}
