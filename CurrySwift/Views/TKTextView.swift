//
//  TKTextView.swift
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


/** This class creates a `UITextView` with placeholder text. */
@objc(TKTextView)
open class TKTextView: UITextView {
	
	private var _placeholderLabel: UILabel?
	
	/** The placeholder label. */
	@objc open var placeholderLabel: UILabel {
		if let existing = _placeholderLabel { return existing }
		
		let label = UILabel(frame: CGRect(x: 2, y: 8, width: bounds.width - 8, height: 0))
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 11)
		label.backgroundColor = .clear
		label.textColor = UIColor(white: 0.80, alpha: 1)
		label.isAccessibilityElement = false
		label.alpha = 0
		
		_placeholderLabel = label
		return label
	}
	
	/** The placeholder text. */
	@objc open var placeholder: String? {
		get { _placeholderLabel?.text }
		set {
			placeholderLabel.text = newValue
			setNeedsDisplay()
		}
	}
	
	/** The text color of the placeholder text. */
	@objc open var placeholderColor: UIColor? {
		get { _placeholderLabel?.textColor }
		set {
			placeholderLabel.textColor = newValue
			setNeedsDisplay()
		}
	}
	
	// MARK: - Init & Friends
	
	public override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		setupView()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	open override func awakeFromNib() {
		super.awakeFromNib()
		setupView()
	}
	
	private func setupView() {
		NotificationCenter.default.addObserver(self, selector: #selector(textChanged(_:)),
		                                       name: UITextView.textDidChangeNotification, object: nil)
	}
	
	open override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		if let label = _placeholderLabel {
			if label.superview == nil {
				addSubview(label)
				sendSubviewToBack(label)
			}
			
			label.frame = CGRect(x: textContainerInset.left + 5,
			                     y: textContainerInset.top,
			                     width: bounds.width - 8,
			                     height: 0)
			label.sizeToFit()
			label.alpha = (text ?? "").isEmpty ? 1 : 0
		}
	}
	
	@objc private func textChanged(_ notification: Notification?) {
		
		guard let placeholder, !placeholder.isEmpty else { return }
		
		let showPlaceholder = (text ?? "").isEmpty
		_placeholderLabel?.alpha = showPlaceholder ? 1 : 0
		accessibilityLabel = showPlaceholder ? _placeholderLabel?.text : text
	}
	
	// MARK: - Properties
	
	open override var font: UIFont? {
		didSet {
			placeholderLabel.font = font
			setNeedsDisplay()
		}
	}
	
	open override var text: String! {
		didSet { textChanged(nil) }
	}
	
	open override var textContainerInset: UIEdgeInsets {
		didSet { setNeedsDisplay() }
	}
	
}
