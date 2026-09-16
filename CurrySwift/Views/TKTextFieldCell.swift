//
//  TKTextFieldCell.swift
//  Created by Devin Ross on 5/18/13.
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


/** A table view cell with a text field. */
@objc(TKTextFieldCell)
open class TKTextFieldCell: UITableViewCell {
	
	/** The text field. */
	@objc public private(set) var textField: UITextField
	
	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		textField = TKTextFieldCell.makeTextField()
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(textField)
	}
	
	public required init?(coder: NSCoder) {
		textField = TKTextFieldCell.makeTextField()
		super.init(coder: coder)
		contentView.addSubview(textField)
	}
	
	private static func makeTextField() -> UITextField {
		let field = UITextField(frame: .zero)
		field.contentVerticalAlignment = .center
		return field
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		var frame = contentView.bounds.insetBy(dx: 14, dy: 4)
		if indentationLevel != 0 && indentationWidth != 0 {
			frame.origin.x = CGFloat(indentationLevel) * indentationWidth
			frame.size.width = contentView.frame.width - frame.minX - 14
		}
		textField.frame = frame
	}
	
	open override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		colorText(active: selected)
	}
	
	open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		super.setHighlighted(highlighted, animated: animated)
		colorText(active: highlighted)
	}
	
	private func colorText(active: Bool) {
		textField.textColor = active ? .white : .black
	}
	
}
