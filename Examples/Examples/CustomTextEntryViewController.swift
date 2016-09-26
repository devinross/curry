//
//  CustomTextEntryViewController.swift
//  Created by Devin Ross on 9/12/16.
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
import curry

class CustomTextEntryViewController: UIViewController {


	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		
		self.edgesForExtendedLayout = .bottom
		
		let numberField = TKCreditCardNumberTextField(frame: CGRect(x: 20, y: 64 + 80, width: self.view.width - 40, height: 60))
		numberField.backgroundColor = UIColor(white: 0.93, alpha: 1)
		numberField.placeholder = "Credit Card Number"
		self.view.addSubview(numberField)
		
		let expirationField = TKCreditCardExpirationTextField(frame: CGRect(x: 20, y: numberField.maxY + 10, width: self.view.width - 40, height: 60))
		expirationField.backgroundColor = UIColor(white: 0.93, alpha: 1)
		expirationField.placeholder = "EXP"
		self.view.addSubview(expirationField)
		
		let zipField = TKCreditCardExpirationTextField(frame: CGRect(x: 20, y: expirationField.maxY + 10, width: self.view.width - 40, height: 60))
		zipField.backgroundColor = UIColor(white: 0.93, alpha: 1)
		zipField.placeholder = "Zip"
		self.view.addSubview(zipField)
		
		
		let cvvField = TKCreditCardExpirationTextField(frame: CGRect(x: 20, y: zipField.maxY + 10, width: self.view.width - 40, height: 60))
		cvvField.backgroundColor = UIColor(white: 0.93, alpha: 1)
		cvvField.placeholder = "CVV"
		self.view.addSubview(cvvField)
		
		let phoneField = TKCreditCardExpirationTextField(frame: CGRect(x: 20, y: cvvField.maxY + 10, width: self.view.width - 40, height: 60))
		phoneField.backgroundColor = UIColor(white: 0.93, alpha: 1)
		phoneField.placeholder = "Phone"
		self.view.addSubview(phoneField)
		
		
	}
	

}


