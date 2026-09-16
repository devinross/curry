//
//  TKWindow.swift
//  Created by Devin Ross on 6/4/09.
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


/** Names of the notifications `TKWindow` posts.

These replace the `TKWindowShakeBegan` style globals: Swift cannot export a
global to Objective-C as an `extern` constant.
*/
@objc(TKWindowNotification)
public final class TKWindowNotification: NSObject {
	
	/** Posted when a motion event begins. */
	@objc public static let shakeBegan = "TKWindowShakeBegan"
	
	/** Posted when a motion event cancels. */
	@objc public static let shakeCancelled = "TKWindowShakeCancelled"
	
	/** Posted when a motion event ends. */
	@objc public static let shakeEnded = "TKWindowShakeEnded"
	
	/** Posted when a remote control event is received. */
	@objc public static let remoteControlEvent = "TKWindowRemoteControlEvent"
	
	private override init() { super.init() }
	
}


extension Notification.Name {
	public static let tkWindowShakeBegan = Notification.Name(TKWindowNotification.shakeBegan)
	public static let tkWindowShakeCancelled = Notification.Name(TKWindowNotification.shakeCancelled)
	public static let tkWindowShakeEnded = Notification.Name(TKWindowNotification.shakeEnded)
	public static let tkWindowRemoteControlEvent = Notification.Name(TKWindowNotification.remoteControlEvent)
}


/** A subclass of `UIWindow` that posts notifications of any motion (ie. shake) events for the device. */
@objc(TKWindow)
open class TKWindow: UIWindow {
	
	open override func remoteControlReceived(with event: UIEvent?) {
		NotificationCenter.default.post(name: .tkWindowRemoteControlEvent, object: event)
	}
	
	// MARK: - Motion Events
	
	open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		NotificationCenter.default.post(name: .tkWindowShakeBegan, object: self)
	}
	
	open override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		NotificationCenter.default.post(name: .tkWindowShakeCancelled, object: self)
	}
	
	open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		NotificationCenter.default.post(name: .tkWindowShakeEnded, object: self)
	}
	
}
