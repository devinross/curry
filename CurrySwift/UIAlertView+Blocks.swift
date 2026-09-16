//
//  UIAlertView+Blocks.swift
//  Created by Devin Ross on 5/1/15.
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


#if !os(tvOS)

private var alertActionsKey: UInt8 = 0


/** Additional block functionality for `UIAlertView`.

- Warning: `UIAlertView` has been deprecated since iOS 9. Prefer
  `UIAlertController`, which curry wraps in `UIAlertController+TKCategory`.
*/
@available(iOS, deprecated: 9.0, message: "Use UIAlertController instead.")
extension UIAlertView: @retroactive UIAlertViewDelegate {
	
	/// One entry per button, in button order; `NSNull` where a button has no block.
	private var actions: NSMutableArray? {
		get { objc_getAssociatedObject(self, &alertActionsKey) as? NSMutableArray }
		set { objc_setAssociatedObject(self, &alertActionsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
	}
	
	/** An alert with a title and message and no buttons yet. */
	@objc(alertWithTitle:message:)
	public static func alert(title: String?, message: String?) -> UIAlertView {
		UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: nil)
	}
	
	/** Adds a button that runs the given block when tapped. */
	@objc(addButtonWithTitle:handler:)
	public func addButton(withTitle title: String, handler block: ((UIAlertView) -> Void)?) {
		
		if actions == nil {
			let existing = NSMutableArray()
			for _ in 0 ..< numberOfButtons { existing.add(NSNull()) }
			actions = existing
		}
		
		delegate = self
		addButton(withTitle: title)
		actions?.add(block.map { $0 as Any } ?? NSNull())
	}
	
	/** Adds a button that runs the given block and becomes the cancel button. */
	@objc(addCancelButtonWithTitle:handler:)
	public func addCancelButton(withTitle title: String, handler block: ((UIAlertView) -> Void)?) {
		addButton(withTitle: title, handler: block)
		cancelButtonIndex = numberOfButtons - 1
	}
	
	public func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
		guard let actions, buttonIndex >= 0, buttonIndex < actions.count,
		      let handler = actions[buttonIndex] as? (UIAlertView) -> Void else { return }
		handler(self)
	}
	
}

#endif
