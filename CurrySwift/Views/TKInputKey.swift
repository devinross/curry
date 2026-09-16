//
//  TKInputKey.swift
//  Created by Devin Ross on 3/21/14.
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


@objc(TKInputKeyType)
public enum TKInputKeyType: Int {
	case `default` = 0
	case dark = 1
	case highlighted = 2
}


/// A rect of `size`, centred inside `parent`. Replaces CGRectCenteredInRectWithSize.
func TKRectCentered(in parent: CGRect, size: CGSize) -> CGRect {
	CGRect(x: ((parent.width - size.width) / 2).rounded(.down),
	       y: ((parent.height - size.height) / 2).rounded(.down),
	       width: size.width, height: size.height)
}


/** `TKInputKey` is an input key to be used by a `TKInputView`. */
@objc(TKInputKey)
open class TKInputKey: UIView {
	
	@objc open var normalType: TKInputKeyType = .default {
		didSet { setHighlighted(false) }
	}
	
	@objc open var highlighedType: TKInputKeyType = .default
	@objc open var runner: Bool = false
	@objc open var canTapAndHold: Bool = false
	
	@objc open var label: UILabel?
	@objc open var symbol: UIImageView?
	
	@objc(keyWithFrame:symbol:normalType:selectedType:runner:)
	public static func key(frame: CGRect, symbol: Any?, normalType normal: TKInputKeyType,
	                       selectedType highlighted: TKInputKeyType, runner: Bool) -> TKInputKey {
		TKInputKey(frame: frame, symbol: symbol, normalType: normal, selectedType: highlighted, runner: runner)
	}
	
	@objc(initWithFrame:symbol:normalType:selectedType:runner:)
	public init(frame: CGRect, symbol: Any?, normalType normal: TKInputKeyType,
	            selectedType highlighted: TKInputKeyType, runner: Bool) {
		
		super.init(frame: frame)
		
		isAccessibilityElement = true
		accessibilityTraits = .keyboardKey
		
		if UIDevice.current.padIdiom {
			
			layer.cornerRadius = 5
			layer.shadowRadius = 0
			layer.shadowColor = UIColor(white: 0, alpha: 0.2).cgColor
			layer.shadowOpacity = 1
			layer.shadowOffset = CGSize(width: 0, height: 1)
			
		} else {
			
			let bottom = UIView(frame: CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1))
			bottom.backgroundColor = UIColor.color(hex: 0xcfd1d5)
			bottom.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
			addSubview(bottom)
			
			let right = UIView(frame: CGRect(x: frame.width - 1, y: 0, width: 1, height: frame.height))
			right.backgroundColor = UIColor.color(hex: 0xcfd1d5)
			right.autoresizingMask = [.flexibleLeftMargin, .flexibleHeight]
			addSubview(right)
		}
		
		if let text = symbol as? String {
			
			let created = UILabel(frame: CGRect(origin: .zero, size: frame.size).insetBy(dx: 5, dy: 5))
			created.font = UIFont.helveticaNeueLight(size: 30)
			created.textAlignment = .center
			created.backgroundColor = .clear
			created.adjustsFontSizeToFitWidth = true
			created.text = text
			addSubview(created)
			label = created
			
			accessibilityLabel = text
			
		} else if let image = symbol as? UIImage {
			
			let created = UIImageView(image: image)
			created.tintColor = UIColor(white: 0.3, alpha: 1)
			created.frame = TKRectCentered(in: bounds, size: created.frame.size)
			addSubview(created)
			symbolView = created
		}
		
		normalType = normal
		highlighedType = highlighted
		self.runner = runner
		setHighlighted(false)
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	/// `symbol` is the public name; this avoids shadowing it inside init.
	private var symbolView: UIImageView? {
		get { symbol }
		set { symbol = newValue }
	}
	
	@objc(setHighlighted:)
	open func setHighlighted(_ highlighted: Bool) {
		
		let type = highlighted ? highlighedType : normalType
		
		switch type {
			case .dark, .default:
				label?.textColor = .black
				backgroundColor = type == .dark ? UIColor.color(hex: 0xe4e4e4) : UIColor(white: 1, alpha: 1)
				symbol?.tintColor = UIColor(white: 0.3, alpha: 1)
				
			case .highlighted:
				symbol?.tintColor = .white
				symbol?.image = symbol?.image?.withRenderingMode(.alwaysTemplate)
				label?.textColor = .white
				backgroundColor = UIColor.color(hex: 0x4185f4)
		}
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		label?.frame = bounds.insetBy(dx: 5, dy: 5)
		if let symbol {
			symbol.frame = TKRectCentered(in: bounds, size: symbol.frame.size)
		}
	}
	
	open override var description: String {
		"<\(String(describing: type(of: self))) \(label?.text ?? "")>"
	}
	
}
