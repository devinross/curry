//
//  ColorsViewController.swift
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

class ColorsViewController: UIViewController {


	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		
		
		let scrollView = UIScrollView(frame: self.view.bounds)
		self.view.addSubview(scrollView)
		
		let pad = CGFloat(20.0)
		let width = (self.view.width - (pad*4.0)) / 3.0
		let middleX = pad*2 + width
		let rightX = pad*3 + width*2
		
		
		let colors = [[UIColor(red: 0, green: 121/255.0, blue: 210/255.0, alpha: 1),]]
		
		
		
		
		var middle = CGRect(x: middleX, y: pad, width: width, height: width)
		var left = CGRect(x:pad, y: pad, width: width, height: width)
		var right = CGRect(x:rightX, y: pad, width: width, height: width)
		
		for array in colors {
			
			
			let block1 = UIView(frame: left, backgroundColor: array.first!)
			scrollView.addSubview(block1)
			
			let block2 = UIView(frame: middle, backgroundColor: array[1])
			scrollView.addSubview(block2)
			
			let block3 = UIView(frame: right, backgroundColor: array.last!)
			scrollView.addSubview(block3)
			
			
			left.origin.y = block1.maxY + pad
			middle.origin.y = block1.maxY + pad;
			right.origin.y = block1.maxY + pad;

			
		}
		
		scrollView.contentHeight = right.origin.y
		
		
		
	}


}
