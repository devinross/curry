//
//  TKWebViewController.swift
//  Created by Devin Ross on 5/24/13.
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
import WebKit


#if os(iOS)

@objc(TKWebViewController)
open class TKWebViewController: UIViewController {
	
	/** The URL that will be loaded by the web view. */
	@objc open var url: URL?
	
	/** The URLRequest that will be loaded by the web view. */
	@objc open var urlRequest: URLRequest?
	
	/** Returns the `WKWebView` managed by the controller object. */
	@objc open var webView: WKWebView!
	
	private var _actionBarButtonItem: UIBarButtonItem?
	private var _loadingActivityBarButtonItem: UIBarButtonItem?
	
	@objc(initWithURL:)
	public init(url: URL) {
		self.url = url
		super.init(nibName: nil, bundle: nil)
	}
	
	@objc(initWithURLRequest:)
	public init(urlRequest: URLRequest) {
		self.urlRequest = urlRequest
		super.init(nibName: nil, bundle: nil)
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	deinit {
		webView?.uiDelegate = nil
		webView?.navigationDelegate = nil
		webView?.stopLoading()
	}
	
	// MARK: - View Lifecycle
	
	open override func loadView() {
		super.loadView()
		
		let created = WKWebView(frame: view.bounds)
		created.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		webView = created
		view.addSubview(created)
	}
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		
		if let url {
			webView.load(URLRequest(url: url))
		} else if let urlRequest {
			webView.load(urlRequest)
		}
	}
	
	// MARK: - Button Actions
	
	/** Show a `UIActivityViewController` to share the URL of the web view.
	@param sender The sender of the action.
	
	The Objective-C original declared this but left the body commented out, so
	the action button did nothing.
	*/
	@objc(showActionSheet:)
	open func showActionSheet(_ sender: Any?) {
		
		guard let current = webView?.url ?? url else { return }
		
		let activity = UIActivityViewController(activityItems: [current], applicationActivities: nil)
		activity.excludedActivityTypes = [.postToWeibo, .saveToCameraRoll, .assignToContact]
		activity.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
		
		present(activity, animated: true)
	}
	
	/** A convenience method for dismissing the presented view controller.
	@param sender The sender that sent the event.
	*/
	@objc(dismiss:)
	open func dismiss(_ sender: Any?) {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: - Properties
	
	/** Returns the `UIBarButtonItem` that shows the share sheet. */
	@objc open var actionBarButtonItem: UIBarButtonItem {
		if let existing = _actionBarButtonItem { return existing }
		let created = UIBarButtonItem.actionItem(target: self, action: #selector(showActionSheet(_:)))
		_actionBarButtonItem = created
		return created
	}
	
	var loadingActivityBarButtonItem: UIBarButtonItem {
		if let existing = _loadingActivityBarButtonItem { return existing }
		let style: UIActivityIndicatorView.Style = .medium
		let created = UIBarButtonItem.activityItem(indicatorStyle: style)
		_loadingActivityBarButtonItem = created
		return created
	}
	
}

#endif
