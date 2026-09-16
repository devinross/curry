//
//  UIViewController+TKCategory.swift
//  Created by Devin Ross on 8/23/13.
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


extension UIViewController {
	
	/** Presents a navigation controller wrapping the given root view controller.
	@param rootViewControllerToPresent The view controller shown at the root of the stack.
	@param animated Whether the presentation is animated.
	@param completion Called once the presentation finishes.
	*/
	@objc(presentNavigationControllerWithRoot:animated:completion:)
	open func presentNavigationController(root rootViewControllerToPresent: UIViewController,
	                                        animated: Bool,
	                                        completion: (() -> Void)?) {
		let navigation = UINavigationController(rootViewController: rootViewControllerToPresent)
		navigation.modalPresentationStyle = rootViewControllerToPresent.modalPresentationStyle
		present(navigation, animated: animated, completion: completion)
	}
	
	/** Presents a simple alert with a single dismiss action.
	@param title The alert's title.
	@param message The alert's message.
	@param dismiss The dismiss button's title, or nil for a localized default.
	*/
	@objc(presentAlertControllWithTitle:message:dismiss:)
	open func presentAlertControll(title: String?, message: String?, dismiss: String?) {
		present(UIAlertController.alertController(title: title, message: message, dismiss: dismiss), animated: true)
	}
	
}
