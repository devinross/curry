//
//  UIControl+Blocks.swift
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


/// Only ever used as a unique address for `objc_getAssociatedObject`.
private nonisolated(unsafe) var handlersKey: UInt8 = 0


/// Retains a block and exposes it as a target/action pair.
private final class TKControlWrapper: NSObject {
	
	let controlEvents: UIControl.Event
	let handler: (Any) -> Void
	
	init(handler: @escaping (Any) -> Void, forControlEvents controlEvents: UIControl.Event) {
		self.handler = handler
		self.controlEvents = controlEvents
		super.init()
	}
	
	@objc func invoke(_ sender: Any) {
		handler(sender)
	}
	
}


/** Additional block functionality for `UIControl`. */
extension UIControl {
	
	/// Wrappers held per control event mask, keyed by the mask's raw value.
	private var eventHandlers: NSMutableDictionary {
		if let existing = objc_getAssociatedObject(self, &handlersKey) as? NSMutableDictionary {
			return existing
		}
		let created = NSMutableDictionary()
		objc_setAssociatedObject(self, &handlersKey, created, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		return created
	}
	
	/** Runs a block when the control sends the given events.
	@param handler The block run when the events fire.
	@param controlEvents The events the block responds to.
	*/
	@objc(addEventHandler:forControlEvents:)
	open func addEventHandler(_ handler: @escaping (Any) -> Void, forControlEvents controlEvents: UIControl.Event) {
		
		let key = NSNumber(value: controlEvents.rawValue)
		let wrappers = eventHandlers[key] as? NSMutableSet ?? {
			let created = NSMutableSet()
			eventHandlers[key] = created
			return created
		}()
		
		let wrapper = TKControlWrapper(handler: handler, forControlEvents: controlEvents)
		wrappers.add(wrapper)
		addTarget(wrapper, action: #selector(TKControlWrapper.invoke(_:)), for: controlEvents)
	}
	
	/** Removes every block registered for the given events. */
	@objc(removeEventHandlersForControlEvents:)
	open func removeEventHandlers(forControlEvents controlEvents: UIControl.Event) {
		
		let key = NSNumber(value: controlEvents.rawValue)
		guard let wrappers = eventHandlers[key] as? NSMutableSet else { return }
		
		for wrapper in wrappers {
			removeTarget(wrapper, action: nil, for: controlEvents)
		}
		eventHandlers.removeObject(forKey: key)
	}
	
	/** Whether any block is registered for the given events. */
	@objc(hasEventHandlersForControlEvents:)
	open func hasEventHandlers(forControlEvents controlEvents: UIControl.Event) -> Bool {
		let key = NSNumber(value: controlEvents.rawValue)
		guard let wrappers = eventHandlers[key] as? NSMutableSet else { return false }
		return wrappers.count > 0
	}
	
}
