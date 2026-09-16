//
//  TKDecimalInputView.swift
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


/** A numeric keypad with a decimal point key. */
@objc(TKDecimalInputView)
open class TKDecimalInputView: TKNumberInputView {
	
	@objc open var decimalKey: TKInputKey!
	
	@objc open override var keypadKeys: [TKInputKey] {
		super.keypadKeys + [decimalKey].compactMap { $0 }
	}
	
	@objc(initWithFrame:withKeysModels:)
	public override init(frame: CGRect, keysModels keys: [TKInputKey]) {
		
		var sized = frame
		sized.size = TKInputView.sizeOfKeyboardForMainScreen
		
		let pad = CGRect(x: 0, y: 0, width: 0.75, height: 1)
		let size = CGSize(width: pad.width * sized.width, height: pad.height * sized.height)
		let decimal = TKInputKey(frame: CGRect(origin: .zero, size: size), symbol: ".",
		                         normalType: .default, selectedType: .dark, runner: true)
		
		super.init(frame: sized, keysModels: [decimal] + keys)
		
		decimalKey = decimal
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		var zeroRect = zeroKey.frame
		zeroRect.size.width = twoKey.frame.maxX - zeroRect.minX
		zeroKey.frame = zeroRect
		
		var decimalRect = zeroKey.frame
		decimalRect.origin.x = threeKey.frame.minX
		decimalRect.size.width = twoKey.frame.width
		decimalKey.frame = decimalRect
	}
	
}
