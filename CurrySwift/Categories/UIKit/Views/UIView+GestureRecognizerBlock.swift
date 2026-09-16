//
//  UIView+GestureRecognizerBlock.swift
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
	
	/** Adds a tap gesture recognizer that runs the given block.
	@param block The callback handler.
	@return The gesture recognizer that was added.
	*/
	@objc(addTapGestureWithHandler:)
	@discardableResult
	public func addTapGesture(handler block: @escaping (UIGestureRecognizer) -> Void) -> UITapGestureRecognizer {
		let tap = UITapGestureRecognizer.recognizer(handler: block)
		addGestureRecognizer(tap)
		return tap
	}
	
	/** Adds a tap gesture recognizer with the given target and action.
	@param target The object the action is sent to.
	@param action The action sent on tap.
	@return The gesture recognizer that was added.
	*/
	@objc(addTapGestureWithTarget:action:)
	@discardableResult
	public func addTapGesture(target: Any?, action: Selector?) -> UITapGestureRecognizer {
		let tap = UITapGestureRecognizer(target: target, action: action)
		addGestureRecognizer(tap)
		return tap
	}
	
}
