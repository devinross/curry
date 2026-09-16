//
//  TKInputView.swift
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


extension Bundle {
	
	/// The bundle carrying curry's keyboard images.
	static var curryResources: Bundle {
		#if SWIFT_PACKAGE
		return .module
		#else
		return Bundle(for: TKInputView.self)
		#endif
	}
	
	/// An image from that bundle, at the main screen's scale.
	static func curryImage(named name: String) -> UIImage? {
		UIImage(named: name, in: curryResources,
		        compatibleWith: UITraitCollection(displayScale: UIScreen.main.scale))
	}
	
}


@objc(TKInputViewDelegate)
public protocol TKInputViewDelegate: NSObjectProtocol {
	@objc func inputView(_ inputView: TKInputView, didSelectKey key: TKInputKey)
}


/** A custom keyboard made of `TKInputKey` views. */
@objc(TKInputView)
open class TKInputView: UIView, UIInputViewAudioFeedback {
	
	@objc open weak var delegate: TKInputViewDelegate?
	@objc open weak var textField: UITextField?
	
	@objc open var backspaceKey: TKInputKey
	@objc open var hideKeyboardKey: TKInputKey?
	@objc public private(set) var selectedKey: TKInputKey?
	@objc open var containerView: UIView!
	
	private weak var originalSelectedKey: TKInputKey?
	private var holdTimer: Timer?
	private var holdCounter: Int = 0
	private var originalFrame: CGRect = .zero
	
	@objc open class var sizeOfKeyboardForMainScreen: CGSize {
		var height: CGFloat = 352
		if UIDevice.current.userInterfaceIdiom == .phone {
			height = UIScreen.main.traitCollection.verticalSizeClass == .compact ? 162 : 216
		}
		return CGSize(width: UIScreen.main.bounds.size.width, height: height)
	}
	
	public convenience init() {
		self.init(frame: CGRect(origin: .zero, size: TKInputView.sizeOfKeyboardForMainScreen), keysModels: [])
	}
	
	public convenience override init(frame: CGRect) {
		self.init(frame: frame, keysModels: [])
	}
	
	@objc(initWithFrame:withKeysModels:)
	public init(frame: CGRect, keysModels keys: [TKInputKey]) {
		
		var sized = frame
		sized.size = TKInputView.sizeOfKeyboardForMainScreen
		
		// Built before super.init because Swift requires stored properties to be set
		// first; the Objective-C original created it lazily off self.frame.
		backspaceKey = TKInputKey(frame: CGRect(x: 0, y: 0, width: sized.width * 0.25, height: sized.height),
		                          symbol: Bundle.curryImage(named: "keyboard-backspace-key"),
		                          normalType: .default, selectedType: .dark, runner: false)
		backspaceKey.canTapAndHold = true
		backspaceKey.accessibilityLabel = NSLocalizedString("Delete", comment: "")
		
		super.init(frame: sized)
		
		originalFrame = sized
		autoresizingMask = [.flexibleHeight, .flexibleWidth]
		backgroundColor = UIColor.color(hex: 0xd7dadf)
		clipsToBounds = true
		
		#if !os(tvOS)
		isMultipleTouchEnabled = false
		isExclusiveTouch = true
		#endif
		
		var containerFrame = sized
		if UIDevice.current.padIdiom {
			containerFrame.size.width = 544
			containerFrame.origin.x = ((sized.width - containerFrame.width) / 2).rounded()
		} else {
			containerFrame.origin = CGPoint(x: 0, y: 1)
		}
		
		let container = UIView(frame: containerFrame)
		container.clipsToBounds = true
		if UIDevice.current.padIdiom {
			container.autoresizingMask = [.flexibleLeftMargin, .flexibleHeight, .flexibleRightMargin]
		}
		containerView = container
		addSubview(container)
		
		for key in keys { install(key: key) }
		
		if UIDevice.current.padIdiom {
			
			let rect = CGRect(x: sized.width - 80 - 32, y: sized.height - 75 - 12, width: 80, height: 75)
			let hide = TKInputKey(frame: rect, symbol: Bundle.curryImage(named: "keyboard-down-keyboard"),
			                      normalType: .default, selectedType: .highlighted, runner: false)
			hide.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
			hide.tag = container.subviews.count
			hide.setHighlighted(false)
			hideKeyboardKey = hide
			addSubview(hide)
			
			if let dotsImage = Bundle.curryImage(named: "keyboard-move-keyboard-dots") {
				let dots = UIImageView(frame: CGRect(origin: CGPoint(x: sized.width - 18, y: sized.height - 57),
				                                     size: dotsImage.size))
				dots.image = dotsImage
				dots.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
				addSubview(dots)
			}
		}
		
		#if !os(tvOS)
		NotificationCenter.default.addObserver(self, selector: #selector(didHideNotification(_:)),
		                                       name: UIResponder.keyboardDidHideNotification, object: nil)
		#endif
	}
	
	public required init?(coder: NSCoder) {
		backspaceKey = TKInputKey(frame: .zero, symbol: nil, normalType: .default, selectedType: .dark, runner: false)
		super.init(coder: coder)
	}
	
	/// Adds a key to the container, numbered and unhighlighted.
	@objc(installKey:)
	open func install(key: TKInputKey) {
		key.tag = containerView.subviews.count
		key.setHighlighted(false)
		containerView.addSubviewToBack(key)
	}
	
	@objc private func didHideNotification(_ sender: Any?) {
		guard traitCollection.userInterfaceIdiom == .phone else { return }
		frame.size.height = traitCollection.verticalSizeClass == .compact ? 162 : 216
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		var bottom: CGFloat = 0
		
		if safeAreaInsets.bottom > 0 {
			frame.size.height += safeAreaInsets.bottom
			frame.origin.y -= safeAreaInsets.bottom
			bottom = safeAreaInsets.bottom
		}
		
		guard traitCollection.userInterfaceIdiom == .phone else { return }
		
		let compact = traitCollection.verticalSizeClass == .compact
		let x = (bounds.width - 450) / 2
		var frame = bounds.insetBy(dx: compact ? x : 0, dy: 0)
		frame.origin.y += 1
		frame.size.height += 1
		frame.size.height -= bottom
		containerView.frame = frame
	}
	
	// MARK: - Touches
	
	open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		guard let touch = touches.first else { return }
		let view = hitTest(touch.location(in: self), with: event)
		
		if selectedKey != nil {
			selectedKey?.setHighlighted(false)
			originalSelectedKey = nil
			selectedKey = nil
		}
		
		guard let key = view as? TKInputKey else { return }
		UIDevice.current.playInputClick()
		
		originalSelectedKey = key
		selectedKey = key
		key.setHighlighted(true)
		containerView.bringSubviewToFront(key)
		
		if key.canTapAndHold {
			holdCounter = 0
			holdTimer?.invalidate()
			holdTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self,
			                                 selector: #selector(holding(_:)), userInfo: nil, repeats: true)
		}
	}
	
	open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		guard let touch = touches.first else { return }
		let currentKey = hitTest(touch.location(in: self), with: event) as? TKInputKey
		
		var on = false
		if originalSelectedKey === currentKey {
			on = true
		} else if originalSelectedKey?.runner == true && currentKey?.runner == true {
			on = true
		}
		
		if selectedKey !== currentKey {
			selectedKey?.setHighlighted(false)
			selectedKey = nil
		}
		
		if on, let currentKey {
			selectedKey = currentKey
			containerView.bringSubviewToFront(currentKey)
			currentKey.setHighlighted(true)
		}
	}
	
	@objc private func holding(_ sender: Any?) {
		
		guard originalSelectedKey === selectedKey else { return }
		
		holdCounter += 1
		let repeats = holdCounter < 6 ? 1 : 5
		for _ in 0 ..< repeats { sendTapKeyEvent() }
	}
	
	/// Sends the selected key to the text field, respecting its delegate's veto.
	open func sendTapKeyEvent() {
		
		guard let selectedKey else { return }
		
		if selectedKey === backspaceKey {
			
			guard let textField, let text = textField.text, !text.isEmpty else { return }
			
			let allowed = textField.delegate?.textField?(textField,
			                                             shouldChangeCharactersIn: NSRange(location: (text as NSString).length - 1, length: 1),
			                                             replacementString: "") ?? true
			if allowed { textField.deleteBackward() }
			
		} else {
			delegate?.inputView(self, didSelectKey: selectedKey)
		}
	}
	
	open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if holdTimer == nil || holdCounter < 1 {
			sendTapKeyEvent()
		}
		touchesCancelled(touches, with: event)
	}
	
	open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		selectedKey?.setHighlighted(false)
		selectedKey = nil
		originalSelectedKey = nil
		holdTimer?.invalidate()
		holdTimer = nil
		holdCounter = 0
	}
	
	open var enableInputClicksWhenVisible: Bool { true }
	
	/// Lets subclasses adopt a key the touch handling already knows about.
	func select(key: TKInputKey?) {
		selectedKey = key
	}
	
}
