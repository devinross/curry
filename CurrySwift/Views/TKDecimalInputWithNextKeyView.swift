//
//  TKDecimalInputWithNextKeyView.swift
//  Created by Devin Ross on 3/21/14.
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


/** A keypad with a next key beside the backspace key. */
@objc(TKDecimalInputWithNextKeyView)
open class TKDecimalInputWithNextKeyView: TKDecimalInputView {
	
	@objc open var nextKey: TKInputKey!
	
	@objc(initWithFrame:withKeysModels:)
	public override init(frame: CGRect, keysModels keys: [TKInputKey]) {
		
		let next = TKInputKey(frame: CGRect(x: 0, y: 0, width: frame.width * 0.25, height: frame.height),
		                      symbol: Bundle.curryImage(named: "keyboard-next-key"),
		                      normalType: .default, selectedType: .dark, runner: false)
		next.accessibilityLabel = NSLocalizedString("Next", comment: "")
		
		super.init(frame: frame, keysModels: keys + [next])
		
		nextKey = next
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		let backRect = backspaceKey.frame
		
		if UIDevice.current.userInterfaceIdiom == .phone {
			nextKey.frame = CGRect(x: backRect.origin.x, y: 0,
			                       width: backRect.width, height: sixKey.frame.maxY)
			backspaceKey.frame = CGRect(x: backRect.origin.x, y: sixKey.frame.maxY,
			                            width: backRect.width, height: zeroKey.frame.maxY - sixKey.frame.maxY)
		} else {
			let keyHeight = sixKey.frame.maxY - oneKey.frame.minY
			nextKey.frame = CGRect(x: backRect.origin.x, y: oneKey.frame.minY,
			                       width: backRect.width, height: keyHeight)
			backspaceKey.frame = CGRect(x: backRect.origin.x, y: eightKey.frame.minY,
			                            width: backRect.width, height: keyHeight)
		}
	}
	
}
