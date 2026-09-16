//
//  TKKeyboardTableViewController.swift
//  Created by Devin Ross on 10/1/13.
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


@objc(TKKeyboardTableViewController)
open class TKKeyboardTableViewController: TKTableViewController, UITextFieldDelegate, UITextViewDelegate {
	
	/** Whether scrolling the table dismisses the keyboard. */
	@objc open var hideKeyboardOnScroll: Bool = false
	
	/** Whether the table scrolls to the field that began editing. */
	@objc open var scrollToTextField: Bool = true
	
	private var scrollLock = false
	private var keyboardRect: CGRect = .zero
	private var prevContentInset: UIEdgeInsets = .zero
	private var prevScrollInset: UIEdgeInsets = .zero
	
	public convenience init() {
		self.init(style: .plain)
	}
	
	@objc(initWithStyle:)
	public override init(style: UITableView.Style) {
		super.init(style: style)
		scrollToTextField = true
		hideKeyboardOnScroll = UIDevice.current.phoneIdiom
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		scrollToTextField = true
		hideKeyboardOnScroll = UIDevice.current.phoneIdiom
	}
	
	// MARK: - View Lifecycle
	
	open override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		#if !os(tvOS)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)),
		                                       name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)),
		                                       name: UIResponder.keyboardWillHideNotification, object: nil)
		#endif
	}
	
	open override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		#if !os(tvOS)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		#endif
	}
	
	// MARK: - Move ScrollView
	
	#if !os(tvOS)
	
	@objc(keyboardWillAppear:)
	open func keyboardWillAppear(_ sender: Notification) {
		
		guard isViewLoaded, view.superview != nil else { return }
		
		scrollLock = true
		
		if keyboardRect == .zero {
			prevScrollInset = tableView.verticalScrollIndicatorInsets
			prevContentInset = tableView.contentInset
		}
		
		keyboardRect = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
		updateInsetWithKeyboard()
	}
	
	@objc(keyboardWillDisappear:)
	open func keyboardWillDisappear(_ sender: Notification) {
		
		keyboardRect = .zero
		
		guard isViewLoaded, view.superview != nil else { return }
		
		UIView.animate(withDuration: 0.05, delay: 0, options: [.beginFromCurrentState, .curveLinear]) {
			self.tableView.contentInset = self.prevContentInset
		}
		tableView.verticalScrollIndicatorInsets = prevScrollInset
	}
	
	#endif
	
	/// Insets the table by however much of the keyboard overlaps it.
	///
	/// The Objective-C original walked UIApplication.windows[0] to convert the frame;
	/// converting from the view's own window does the same and avoids that deprecated API.
	private func updateInsetWithKeyboard() {
		
		let converted = view.convert(keyboardRect, from: view.window)
		let overlap = converted.intersection(view.bounds)
		let bottom = overlap.isNull ? 0 : overlap.height
		
		UIView.animate(withDuration: 0.05, delay: 0, options: [.beginFromCurrentState, .curveLinear]) {
			self.tableView.contentInset = UIEdgeInsets(top: self.tableView.contentInset.top, left: 0, bottom: bottom, right: 0)
			self.tableView.verticalScrollIndicatorInsets = UIEdgeInsets(top: self.tableView.verticalScrollIndicatorInsets.top, left: 0, bottom: bottom, right: 0)
		}
	}
	
	// MARK: - Rotations
	
	open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		coordinator.animate(alongsideTransition: nil) { _ in self.updateInsetWithKeyboard() }
	}
	
	// MARK: - Text Field & Text View Delegate
	
	open func textViewDidBeginEditing(_ textView: UITextView) {
		guard scrollToTextField, textView.isDescendant(of: tableView) else { return }
		scrollLock = true
		perform(#selector(scrollTo(view:)), with: textView, afterDelay: 0.1)
	}
	
	open func textFieldDidBeginEditing(_ textField: UITextField) {
		guard scrollToTextField, textField.isDescendant(of: tableView) else { return }
		scrollLock = true
		perform(#selector(scrollTo(view:)), with: textField, afterDelay: 0.1)
	}
	
	// MARK: - UIScrollView Delegate
	
	open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		if hideKeyboardOnScroll && !scrollLock {
			resignResponders()
		}
	}
	
	open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		scrollLock = false
	}
	
	open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		scrollLock = false
	}
	
	open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if !decelerate { scrollLock = false }
	}
	
	@objc private func unlock() {
		DispatchQueue.main.async { self.scrollLock = false }
	}
	
	// MARK: - Public Functions
	
	/** Scroll the table so the given view is visible above the keyboard. */
	@objc(scrollToView:)
	open func scrollTo(view: UIView) {
		
		if let textView = view as? UITextView {
			
			var rect = view.convert(textView.caretRect(for: textView.selectedTextRange?.start ?? textView.beginningOfDocument), to: tableView)
			rect.size.height += (textView.font?.lineHeight ?? 0) * 3 + (textView.inputAccessoryView?.frame.height ?? 0)
			tableView.scrollRectToVisible(rect, animated: true)
			
		} else {
			
			var rect = view.convert(view.bounds, to: tableView)
			rect.size.height += 15
			tableView.scrollRectToVisible(rect, animated: true)
		}
		
		perform(#selector(unlock), with: nil, afterDelay: 0.35)
	}
	
	/** Subclass this to resign whichever responders the screen owns. */
	@objc open func resignResponders() {
	}
	
}
