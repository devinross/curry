//
//  TKCreditCardNumberTextField.swift
//  Created by Devin Ross on 4/10/15.
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


/** This class is a subclass of `UITextField` for specifically entering credit card numbers. */
@objc(TKCreditCardNumberTextField)
open class TKCreditCardNumberTextField: UITextField {
	
	/** Return YES if the current given text is a valid credit card number. */
	@objc open var isValidCreditCard: Bool {
		((text ?? "").tkDigitsOnly as NSString).isValidCreditCardNumber
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		configure()
	}
	
	@objc private func textFieldDidChange(_ sender: Any?) {
		
		var remaining = (text ?? "").tkDigitsOnly.tkPrefix(19)
		
		// American Express groups its digits 4-6-5 rather than in fours.
		let isAmex = (remaining as NSString).creditCardType?.hasPrefix("Amer") ?? false
		var group = 4
		
		var grouped = ""
		while !remaining.isEmpty {
			
			let chunk = remaining.tkPrefix(group)
			grouped += chunk
			if chunk.count == group {
				grouped += " "
			}
			
			remaining = String(remaining.dropFirst(min(remaining.count, group)))
			
			if isAmex && group == 4 {
				group = 6
			} else if isAmex && group == 6 {
				group = 5
			}
		}
		
		text = grouped.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789\u{8}").inverted)
	}
	
	private func configure() {
		placeholder = NSLocalizedString("Card Number", comment: "")
		keyboardType = .numberPad
		autocorrectionType = .no
		addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
	}
	
}
