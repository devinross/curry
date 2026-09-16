//
//  TKTableViewController.swift
//  Created by Devin Ross on 11/19/10.
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


@objc(TKTableViewController)
open class TKTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
	
	/** The table view managed by the controller. */
	@objc open var tableView: UITableView!
	
	/** The style the table view was created with. */
	@objc public private(set) var style: UITableView.Style
	
	/** Whether the selected row is deselected when the view appears. */
	@objc open var clearsSelectionOnViewWillAppear: Bool = true
	
	private var tableViewContentOffset: CGPoint = .zero
	private var _searchBar: UISearchBar?
	private var _searchController: UISearchController?
	
	// MARK: - Init & Friends
	
	public convenience init() {
		self.init(style: .plain)
	}
	
	@objc(initWithStyle:)
	public init(style: UITableView.Style) {
		self.style = style
		super.init(nibName: nil, bundle: nil)
	}
	
	public required init?(coder: NSCoder) {
		style = .plain
		super.init(coder: coder)
	}
	
	// MARK: - View Load / Events
	
	open override func loadView() {
		super.loadView()
		
		let created = UITableView(frame: view.bounds, style: style)
		created.delegate = self
		created.dataSource = self
		created.showsVerticalScrollIndicator = true
		created.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		created.contentOffset = tableViewContentOffset
		
		tableView = created
		view.addSubview(created)
	}
	
	open override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if clearsSelectionOnViewWillAppear, let selected = tableView?.indexPathForSelectedRow {
			tableView.deselectRow(at: selected, animated: animated)
		}
	}
	
	// MARK: - TableView Delegate & DataSource
	
	open func numberOfSections(in tableView: UITableView) -> Int {
		0
	}
	
	open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		0
	}
	
	/// Subclasses are expected to override this. The Objective-C original returned nil,
	/// which UITableView does not accept, so this returns a blank cell instead.
	open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		UITableViewCell()
	}
	
	// MARK: - Search
	
	#if os(iOS)
	
	/** A search bar sized to the top of the view. */
	@objc open var searchBar: UISearchBar {
		if let existing = _searchBar { return existing }
		let created = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
		created.autoresizingMask = .flexibleWidth
		_searchBar = created
		return created
	}
	
	/** A search controller wired to this view controller. */
	@objc open var searchController: UISearchController {
		if let existing = _searchController { return existing }
		let created = UISearchController(searchResultsController: nil)
		created.searchResultsUpdater = self
		created.delegate = self
		_searchController = created
		return created
	}
	
	#endif
	
}


#if os(iOS)

extension TKTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
	
	open func updateSearchResults(for searchController: UISearchController) {
	}
	
	open func willPresentSearchController(_ searchController: UISearchController) {
	}
	
	open func didPresentSearchController(_ searchController: UISearchController) {
	}
	
	open func willDismissSearchController(_ searchController: UISearchController) {
	}
	
	open func didDismissSearchController(_ searchController: UISearchController) {
	}
	
}

#endif
