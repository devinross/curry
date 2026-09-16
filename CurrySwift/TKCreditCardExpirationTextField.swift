//
//  TKCreditCardExpirationTextField.swift
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


/** This class is a subclass of `UITextField` for specifically entering expiration dates in the format MM / YY. */
@objc(TKCreditCardExpirationTextField)
open class TKCreditCardExpirationTextField: UITextField {
	
	/** The month typed in. */
	@objc open var month: String {
		(text ?? "").tkDigitsOnly.tkPrefix(2)
	}
	
	/** The year typed in. */
	@objc open var year: String? {
		let digits = (text ?? "").tkDigitsOnly
		guard digits.count > 2 else { return nil }
		return String(digits.dropFirst(2)).tkPrefix(2)
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
		
		// Deleting into the separator should take the whole separator with it.
		if let current = text, current.hasSuffix(" /") {
			text = current.tkPrefix(1)
			return
		}
		
		let digits = (text ?? "").tkDigitsOnly
		let month = self.month
		
		if let year, !year.isEmpty {
			text = "\(month) / \(year)"
		} else if month.count > 1 {
			text = month + " / "
		} else {
			text = digits
		}
	}
	
	private func configure() {
		placeholder = NSLocalizedString("MM / YY", comment: "")
		keyboardType = .numberPad
		autocorrectionType = .no
		addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
	}
	
}
