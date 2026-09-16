//
//  UIAlertView+TKCategory.swift
//  Created by Devin Ross on 10/4/13.
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


#if !os(tvOS)

/** Additional functionality for `UIAlertView`.

- Warning: `UIAlertView` has been deprecated since iOS 9. Prefer
  `UIAlertController`, which curry wraps in `UIAlertController+TKCategory`.
*/
@available(iOS, deprecated: 9.0, message: "Use UIAlertController instead.")
extension UIAlertView {
	
	/** Creates and shows an alert with a single dismiss button. */
	@objc(showAlertViewWithTitle:message:dismiss:)
	@discardableResult
	open class func showAlertView(title: String?, message: String?, dismiss: String?) -> UIAlertView {
		let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: dismiss)
		alert.show()
		return alert
	}
	
}

#endif
