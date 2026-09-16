//
//  UIBarButtonItem+TKCategory.swift
//  Created by Devin Ross on 3/23/11.
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


/** Additional functionality for `UIBarButtonItem`. */
extension UIBarButtonItem {
	
	/** A bar item backed by a custom image button.
	@param image The button's normal image.
	@param highlightedImage The button's highlighted image.
	@param target The object the selector is sent to.
	@param selector The selector sent on tap.
	*/
	@objc(barButtonItemWithImage:highlightedImage:target:selector:)
	open class func barButtonItem(image: UIImage, highlightedImage: UIImage, target: Any?, selector: Selector?) -> UIBarButtonItem {
		
		let button = UIButton.button(frame: CGRect(origin: .zero, size: image.size),
		                             image: image,
		                             highlightedImage: highlightedImage)
		if let selector {
			button.addTarget(target, action: selector, for: .touchUpInside)
		}
		
		let item = UIBarButtonItem(customView: button)
		item.target = target as AnyObject?
		item.action = selector
		return item
	}
	
	/** A system action item. */
	@objc(actionItemWithTarget:action:)
	open class func actionItem(target: Any?, action: Selector?) -> UIBarButtonItem {
		UIBarButtonItem(barButtonSystemItem: .action, target: target, action: action)
	}
	
	/** A system done item. */
	@objc(doneItemWithTarget:action:)
	open class func doneItem(target: Any?, action: Selector?) -> UIBarButtonItem {
		UIBarButtonItem(barButtonSystemItem: .done, target: target, action: action)
	}
	
	/** A system cancel item. */
	@objc(cancelItemWithTarget:action:)
	open class func cancelItem(target: Any?, action: Selector?) -> UIBarButtonItem {
		UIBarButtonItem(barButtonSystemItem: .cancel, target: target, action: action)
	}
	
	/** A system save item, styled as a done button. */
	@objc(saveItemWithTarget:action:)
	open class func saveItem(target: Any?, action: Selector?) -> UIBarButtonItem {
		let item = UIBarButtonItem(barButtonSystemItem: .save, target: target, action: action)
		item.style = .done
		return item
	}
	
	/** A bar item showing a spinning activity indicator. */
	@objc open class var activityItem: UIBarButtonItem {
		activityItem(indicatorStyle: .medium)
	}
	
	/** A bar item showing a spinning activity indicator.
	@param style The style of the indicator.
	*/
	@objc(activityItemWithIndicatorStyle:)
	open class func activityItem(indicatorStyle style: UIActivityIndicatorView.Style) -> UIBarButtonItem {
		let indicator = UIActivityIndicatorView(style: style)
		indicator.startAnimating()
		return UIBarButtonItem(customView: indicator)
	}
	
	/** A fixed width spacer item. */
	@objc(fixedSpaceItemWithWidth:)
	open class func fixedSpaceItem(width: CGFloat) -> UIBarButtonItem {
		let item = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
		item.width = width
		return item
	}
	
	/** A flexible width spacer item. */
	@objc open class var flexibleSpaceItem: UIBarButtonItem {
		UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
	}
	
}
