//
//  CustomKeyboardViewController.swift
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

class CustomKeyboardViewController: UIViewController {

	
	override func loadView() {
		super.loadView()
		
		self.view.backgroundColor = UIColor.white
		self.edgesForExtendedLayout = .bottom

		let textField = UITextField(frame: CGRectMakeInset(0, 0, self.view.width, 100, 30, 20))
		textField.autoresizingMask = [.flexibleWidth]
		textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
		self.view.addSubview(textField)
		
		let input = TKNumberInputView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 216))
		input.textField = textField
		textField.inputView = input
		
		
	}
	

}
