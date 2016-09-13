//
//  CustomTextEntryViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/12/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit
import curry

class CustomTextEntryViewController: UIViewController {


	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		
		let numberField = TKCreditCardNumberTextField(frame: CGRect(x: 20, y: 80, width: self.view.width - 40, height: 60))
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


