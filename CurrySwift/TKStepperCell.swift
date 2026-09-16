//
//  TKStepperCell.swift
//  Created by Devin Ross on 4/9/14.
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


#if os(iOS)

@objc(TKStepperCell)
open class TKStepperCell: UITableViewCell {
	
	@objc open var stepper: UIStepper
	
	private let cellStyle: UITableViewCell.CellStyle
	
	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		stepper = UIStepper(frame: .zero)
		cellStyle = style
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		accessoryView = stepper
	}
	
	public required init?(coder: NSCoder) {
		stepper = UIStepper(frame: .zero)
		cellStyle = .default
		super.init(coder: coder)
		accessoryView = stepper
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		if cellStyle == .value1 {
			detailTextLabel?.frame.origin.x -= 4
		}
	}
	
}

#endif
