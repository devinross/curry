//
//  ProgressTaskViewController.swift
//  Created by Devin Ross on 5/2/17.
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

class ProgressTaskViewController: UIViewController {
	
	var task : TKProgressDataTask?
	var progress : UIProgressView?

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let str = "https://cdn.dribbble.com/users/20115/screenshots/2291710/confetti400-30.gif"
		let url = URL(string: str)
		
		
		let progress = UIProgressView(progressViewStyle: .bar)
		progress.tintColor = UIColor.blue
		progress.frame = CGRect(x: 0, y: 100, width: self.view.width, height: 10)
		self.view.addSubview(progress)
		
		let task = URLSession.progressDataTask(with: url!, progressHandler: { (progressAmount, total) in
			
			print("\(progressAmount) \(total) \(progressAmount/total)")
			
			progress.setProgress(Float(progressAmount/total), animated: true)
			
			
		}, completionHandler: { (data, response, error) in
			print("\(String(describing: data?.count)) \(String(describing: response)) \(String(describing: error))")
			
		})
		task.resume()
		
		self.task = task
	}
    


}
