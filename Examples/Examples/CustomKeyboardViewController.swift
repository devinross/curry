//
//  CustomKeyboardViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/12/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit

class CustomKeyboardViewController: UIViewController {

	
	override func loadView() {
		super.loadView()
		
		self.view.backgroundColor = UIColor.white
		
		let textField = UITextField(frame: CGRectMakeInset(0, 0, self.view.width, 100, 30, 20))
		textField.autoresizingMask = [.flexibleWidth]
		textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
		self.view.addSubview(textField)
		
		let input = TKNumberInputView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 216))
		input.textField = textField
		textField.inputView = input
		
		
	}
	

}
