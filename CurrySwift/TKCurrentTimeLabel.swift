//
//  TKCurrentTimeLabel.swift
//  Created by Devin Ross on 2/10/15.
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


/** `TKCurrentTimeLabel` is a label that prints out the current time. */
@objc(TKCurrentTimeLabel)
open class TKCurrentTimeLabel: UILabel {
	
	private var timer: Timer?
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		configure()
	}
	
	private func configure() {
		NotificationCenter.default.addObserver(self, selector: #selector(handleEnteredBackground(_:)),
		                                       name: UIApplication.didEnterBackgroundNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleEnteredForeground(_:)),
		                                       name: UIApplication.didBecomeActiveNotification, object: nil)
		textAlignment = .center
	}
	
	open override func willMove(toWindow newWindow: UIWindow?) {
		guard newWindow != nil else {
			timer?.invalidate()
			timer = nil
			return
		}
		updateTime()
		startTimer()
	}
	
	@objc private func updateTime() {
		attributedText = attributeString(time: currentTime)
	}
	
	private func startTimer() {
		timer?.invalidate()
		let created = Timer(timeInterval: 5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
		RunLoop.current.add(created, forMode: .default)
		timer = created
	}
	
	@objc private func handleEnteredBackground(_ sender: Any?) {
		timer?.invalidate()
		timer = nil
	}
	
	@objc private func handleEnteredForeground(_ sender: Any?) {
		updateTime()
		if window != nil { startTimer() }
	}
	
	// MARK: - Functions for Subclassing
	
	/** For subclassing, return the current time string. */
	@objc open var currentTime: String {
		DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
	}
	
	/** For subclassing, apply any text styling here.
	@param time The current time text.
	@return An attributed text string of the time string.
	*/
	@objc(attributeStringWithTime:)
	open func attributeString(time: String) -> NSAttributedString {
		NSAttributedString(string: time)
	}
	
}
