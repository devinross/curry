//
//  Timer+Blocks.swift
//  Created by Devin Ross on 5/22/15.
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

import Foundation


/** Additional functionality for `Timer` with block functionality. */
extension Timer {
	
	/** Create a scheduled timer that runs a block when it fires.
	@param seconds The time until the timer fire.
	@param repeats A flag for having the timer repeat.
	@param block The block that will be called by the timer.
	@return The `Timer` object.
	*/
	@objc(tk_scheduledTimerWithTimeInterval:repeats:block:)
	@discardableResult
	open class func tk_scheduledTimer(withTimeInterval seconds: TimeInterval, repeats: Bool, block: @escaping () -> Void) -> Timer {
		Timer.scheduledTimer(withTimeInterval: seconds, repeats: repeats) { _ in block() }
	}
	
	/** Create an unscheduled timer that runs a block when it fires.
	@param seconds The time until the timer fire.
	@param repeats A flag for having the timer repeat.
	@param block The block that will be called by the timer.
	@return The `Timer` object.
	*/
	@objc(tk_timerWithTimeInterval:repeats:block:)
	open class func tk_timer(withTimeInterval seconds: TimeInterval, repeats: Bool, block: @escaping () -> Void) -> Timer {
		Timer(timeInterval: seconds, repeats: repeats) { _ in block() }
	}
	
	/** Create a timer with a given fire date that runs a block when it fires.
	@param date The date the timer will first fire.
	@param seconds The time until the timer fire.
	@param repeats A flag for having the timer repeat.
	@param block The block that will be called by the timer.
	*/
	@objc(initWithTkFireDate:interval:repeats:block:)
	public convenience init(tkFireDate date: Date, interval seconds: TimeInterval, repeats: Bool, block: @escaping () -> Void) {
		self.init(fire: date, interval: seconds, repeats: repeats) { _ in block() }
	}
	
}
