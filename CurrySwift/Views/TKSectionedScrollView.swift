//
//  TKSectionedScrollView.swift
//  Created by Devin Ross on 4/8/15.
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


@objc(TKSectionedScrollViewDelegate)
public protocol TKSectionedScrollViewDelegate: NSObjectProtocol {
	
	@objc optional func sectionedScrollView(_ sectionedScrollView: TKSectionedScrollView, scrollViewDidScroll scrollView: UIScrollView)
	@objc optional func sectionedScrollView(_ sectionedScrollView: TKSectionedScrollView, scrollViewDidEndDragging scrollView: UIScrollView, willDecelerate decelerate: Bool)
	@objc optional func sectionedScrollView(_ sectionedScrollView: TKSectionedScrollView, scrollViewDidEndDecelerating scrollView: UIScrollView)
	@objc optional func sectionedScrollView(_ sectionedScrollView: TKSectionedScrollView, scrollViewWillBeginDragging scrollView: UIScrollView)
	
}


/** A row of side by side scroll views that hand off to one another at their edges. */
@objc(TKSectionedScrollView)
open class TKSectionedScrollView: UIView, UIScrollViewDelegate {
	
	@objc open weak var delegate: TKSectionedScrollViewDelegate?
	@objc open var scrollViews: [UIScrollView] = []
	@objc public private(set) var movingPages: Bool = false
	
	private var canMoveRight = false
	private var canMoveLeft = false
	private var _currentSection: Int = 0
	
	@objc open var currentSection: Int {
		get { _currentSection }
		set { setCurrentSection(newValue, animated: false) }
	}
	
	@objc(initWithFrame:numberOfSections:)
	public init(frame: CGRect, numberOfSections sections: Int) {
		super.init(frame: frame)
		
		var minX: CGFloat = 0
		var created: [UIScrollView] = []
		
		for index in 0 ..< sections {
			var rect = bounds
			rect.origin.x = minX
			let scrollView = UIScrollView(frame: rect)
			scrollView.tag = index
			scrollView.delegate = self
			scrollView.showsHorizontalScrollIndicator = false
			addSubview(scrollView)
			minX = scrollView.frame.maxX
			created.append(scrollView)
		}
		
		_currentSection = 0
		scrollViews = created
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	// MARK: - UIScrollView Delegate
	
	open func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		delegate?.sectionedScrollView?(self, scrollViewDidScroll: scrollView)
		
		guard currentSection == scrollView.tag, !movingPages else { return }
		
		let width = frame.width
		let endOffset = scrollView.contentOffsetFromEnd.x
		let startOffset = scrollView.contentOffset.x
		
		if scrollView.tag + 1 < scrollViews.count {
			let next = scrollViews[scrollView.tag + 1]
			let x = width * CGFloat(next.tag) - width * CGFloat(currentSection)
			next.frame = CGRect(origin: CGPoint(x: min(x + endOffset, x), y: next.frame.minY), size: next.frame.size)
		}
		
		if scrollView.tag > 0 {
			let previous = scrollViews[scrollView.tag - 1]
			let x = width * CGFloat(previous.tag) - width * CGFloat(currentSection)
			previous.frame = CGRect(origin: CGPoint(x: max(x - startOffset, x), y: previous.frame.minY), size: previous.frame.size)
		}
	}
	
	open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		
		delegate?.sectionedScrollView?(self, scrollViewWillBeginDragging: scrollView)
		
		canMoveLeft = false
		canMoveRight = false
		
		if scrollView.contentOffset.x < 5 && scrollView.tag > 0 {
			canMoveLeft = true
		} else if scrollView.contentOffsetFromEnd.x < 5 && scrollView.tag + 1 < scrollViews.count {
			canMoveRight = true
		}
	}
	
	open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		
		delegate?.sectionedScrollView?(self, scrollViewDidEndDragging: scrollView, willDecelerate: decelerate)
		
		if scrollView.contentOffsetFromEnd.x < 0 && canMoveRight {
			slide(to: _currentSection + 1)
		} else if scrollView.contentOffset.x < 0 && canMoveLeft {
			slide(to: _currentSection - 1)
		}
	}
	
	open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		delegate?.sectionedScrollView?(self, scrollViewDidEndDecelerating: scrollView)
	}
	
	private func slide(to section: Int) {
		
		_currentSection = section
		movingPages = true
		
		UIView.animate(withDuration: 0.3, delay: 0,
		               options: [.beginFromCurrentState, .allowAnimatedContent, .curveEaseInOut]) {
			self.layOutSections()
		} completion: { _ in
			self.movingPages = false
		}
	}
	
	/// Places each scroll view side by side, with the current section on screen.
	private func layOutSections(resettingOffsets: Bool = false) {
		
		let width = frame.width
		
		for (index, scrollView) in scrollViews.enumerated() {
			
			let minX = width * CGFloat(index) - width * CGFloat(_currentSection)
			scrollView.center = CGPoint(x: minX + scrollView.frame.width / 2, y: scrollView.center.y)
			
			if resettingOffsets {
				let end = scrollView.contentSize.width - scrollView.frame.width
				scrollView.contentOffset = CGPoint(x: index >= _currentSection ? 0 : end, y: 0)
			}
		}
	}
	
	// MARK: - Properties
	
	@objc(setCurrentSection:animated:)
	open func setCurrentSection(_ currentSection: Int, animated: Bool) {
		
		_currentSection = currentSection
		
		guard animated else {
			UIView.performWithoutAnimation { self.layOutSections(resettingOffsets: true) }
			return
		}
		
		UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: []) {
			self.layOutSections(resettingOffsets: true)
		}
	}
	
}
