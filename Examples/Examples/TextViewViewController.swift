//
//  TextViewViewController.swift
//  Created by Devin Ross on 5/5/17.
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

class TextViewViewController: UIViewController {
	
	var textView : TKTextView!
	var insetSlider : UISlider!
	var textSizeSlider : UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
		
		
		self.edgesForExtendedLayout = .left
		let textView = TKTextView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 200).insetBy(dx: 10, dy: 10))
		textView.placeholder = "Placeholder"
		textView.backgroundColor = UIColor.white
		self.textView = textView
		self.view.addSubview(textView)
		
		let slider = UISlider(frame: CGRect(x: 0, y: textView.maxY + 10, width: self.view.width, height: 30).insetBy(dx: 20, dy: 0))
		self.textSizeSlider = slider
		slider.minimumValue = 10
		slider.maximumValue = 30
		slider.addEventHandler({ (sender) in
			self.textView.font = UIFont.systemFont(ofSize: CGFloat(self.textSizeSlider.value))
		}, for: .valueChanged)
		self.view.addSubview(slider)

		let insetSlider = UISlider(frame: CGRect(x: 0, y: slider.maxY + 10, width: self.view.width, height: 30).insetBy(dx: 20, dy: 0))
		insetSlider.minimumValue = 0
		insetSlider.maximumValue = 12
		insetSlider.addEventHandler({ (sender) in
			let inset = CGFloat(self.insetSlider.value)
			self.textView.textContainerInset = UIEdgeInsets.init(top: inset, left: inset, bottom: inset, right: inset)
		}, for: .valueChanged)
		self.insetSlider = insetSlider
		self.view.addSubview(self.insetSlider)
		

    }
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.textView.becomeFirstResponder()
	}

}
