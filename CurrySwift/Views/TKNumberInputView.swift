//
//  TKNumberInputView.swift
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


/** A numeric keypad built from `TKInputKey` views. */
@objc(TKNumberInputView)
open class TKNumberInputView: TKInputView {
	
	@objc open var padRect: CGRect = CGRect(x: 0, y: 0, width: 0.75, height: 1)
	
	@objc open var oneKey: TKInputKey!
	@objc open var twoKey: TKInputKey!
	@objc open var threeKey: TKInputKey!
	@objc open var fourKey: TKInputKey!
	@objc open var fiveKey: TKInputKey!
	@objc open var sixKey: TKInputKey!
	@objc open var sevenKey: TKInputKey!
	@objc open var eightKey: TKInputKey!
	@objc open var nineKey: TKInputKey!
	@objc open var zeroKey: TKInputKey!
	
	@objc open var keypadKeys: [TKInputKey] {
		[oneKey, twoKey, threeKey, fourKey, fiveKey, sixKey, sevenKey, eightKey, nineKey, zeroKey].compactMap { $0 }
	}
	
	@objc(initWithFrame:withKeysModels:)
	public override init(frame: CGRect, keysModels keys: [TKInputKey]) {
		
		var sized = frame
		sized.size = TKInputView.sizeOfKeyboardForMainScreen
		
		// The digits are built before super.init and adopted afterwards: Swift does not
		// allow touching self before the superclass initialiser runs, which the
		// Objective-C original did.
		let pad = CGRect(x: 0, y: 0, width: 0.75, height: 1)
		let size = CGSize(width: pad.width * sized.width, height: pad.height * sized.height)
		let digits = (0 ... 9).map { digit in
			TKInputKey(frame: CGRect(origin: .zero, size: size), symbol: "\(digit)",
			           normalType: .default, selectedType: .dark, runner: true)
		}
		
		// digits[0] is "0", which sits last on the keypad.
		let ordered = Array(digits[1 ... 9]) + [digits[0]]
		
		super.init(frame: sized, keysModels: ordered + keys)
		
		padRect = pad
		oneKey = digits[1];   twoKey = digits[2];   threeKey = digits[3]
		fourKey = digits[4];  fiveKey = digits[5];  sixKey = digits[6]
		sevenKey = digits[7]; eightKey = digits[8]; nineKey = digits[9]
		zeroKey = digits[0]
		
		install(key: backspaceKey)
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		let containerSize = containerView.frame.size
		let pad = CGRect(x: (padRect.origin.x * containerSize.width).rounded(),
		                 y: (padRect.origin.y * containerSize.height).rounded(),
		                 width: (padRect.size.width * containerSize.width).rounded(),
		                 height: (padRect.size.height * containerSize.height).rounded())
		
		var width = (pad.width / 3).rounded(.down)
		var height = (pad.height / 4).rounded(.down)
		var xPad: CGFloat = 0, leftInset: CGFloat = 0, vertInset: CGFloat = 0, vertSpace: CGFloat = 0
		var bottomPad: CGFloat = 2
		
		if UIDevice.current.padIdiom {
			xPad = 16; leftInset = 24; vertInset = 12; vertSpace = 10
			width = ((pad.width - leftInset - leftInset - (xPad * 2)) / 3).rounded(.down)
			height = ((pad.height - vertInset - vertInset - (vertSpace * 3)) / 4).rounded(.down)
			bottomPad = 0
		}
		
		let size = CGSize(width: width, height: height)
		let columns = [leftInset, leftInset + width + xPad, leftInset + width * 2 + xPad * 2]
		let rows = [vertInset, height + vertSpace + vertInset, (height + vertSpace) * 2 + vertInset]
		
		oneKey.frame   = CGRect(origin: CGPoint(x: columns[0], y: rows[0]), size: size)
		twoKey.frame   = CGRect(origin: CGPoint(x: columns[1], y: rows[0]), size: size)
		threeKey.frame = CGRect(origin: CGPoint(x: columns[2], y: rows[0]), size: size)
		fourKey.frame  = CGRect(origin: CGPoint(x: columns[0], y: rows[1]), size: size)
		fiveKey.frame  = CGRect(origin: CGPoint(x: columns[1], y: rows[1]), size: size)
		sixKey.frame   = CGRect(origin: CGPoint(x: columns[2], y: rows[1]), size: size)
		sevenKey.frame = CGRect(origin: CGPoint(x: columns[0], y: rows[2]), size: size)
		eightKey.frame = CGRect(origin: CGPoint(x: columns[1], y: rows[2]), size: size)
		nineKey.frame  = CGRect(origin: CGPoint(x: columns[2], y: rows[2]), size: size)
		
		let bottom = height * 3 + vertSpace * 3 + vertInset
		zeroKey.frame = CGRect(x: leftInset, y: bottom,
		                       width: width * 3 + xPad * 2, height: pad.height + bottomPad - bottom)
		
		let minX = threeKey.frame.maxX + xPad
		
		if UIDevice.current.userInterfaceIdiom == .phone {
			backspaceKey.frame = CGRect(x: minX, y: vertInset,
			                            width: containerView.frame.width - minX + 1,
			                            height: pad.height + bottomPad)
		} else {
			backspaceKey.frame = CGRect(x: minX, y: vertInset, width: size.width, height: height)
		}
	}
	
	open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		if let key = selectedKey, keypadKeys.contains(key) {
			insert(key: key)
			super.touchesCancelled(touches, with: event)
			return
		}
		
		super.touchesEnded(touches, with: event)
	}
	
	/// Inserts a keypad key's text, respecting the text field delegate's veto.
	func insert(key: TKInputKey) {
		
		guard let textField, let text = key.label?.text else { return }
		
		let length = (textField.text as NSString?)?.length ?? 0
		let allowed = textField.delegate?.textField?(textField,
		                                             shouldChangeCharactersIn: NSRange(location: length, length: 0),
		                                             replacementString: text) ?? true
		if allowed { textField.insertText(text) }
	}
	
}
