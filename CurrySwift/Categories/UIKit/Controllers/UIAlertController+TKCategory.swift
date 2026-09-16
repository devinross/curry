//
//  UIAlertController+TKCategory.swift
//  Created by Devin Ross on 10/2/15.
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


extension UIAlertController {
	
	/** An alert with a single dismiss action.
	@param title The alert's title.
	@param message The alert's message.
	@param dismiss The dismiss button's title, or nil for a localized default.
	*/
	@objc(alertControllerWithTitle:message:dismiss:)
	open class func alertController(title: String?, message: String?, dismiss: String?) -> UIAlertController {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let dismissTitle = dismiss ?? NSLocalizedString("Dismiss", comment: "Dismiss Alert View")
		alert.addAction(UIAlertAction(title: dismissTitle, style: .cancel, handler: nil))
		return alert
	}
	
	/** Adds an action built from a title, a style and a handler. */
	@objc(addActionWithTitle:style:handler:)
	open func addAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) {
		addAction(UIAlertAction(title: title, style: style, handler: handler))
	}
	
}
