//
//  TKCollectionViewController.swift
//  Created by Devin Ross on 10/23/15.
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


@objc(TKCollectionViewController)
open class TKCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
	@objc open var collectionView: UICollectionView!
	@objc public private(set) var collectionViewLayout: UICollectionViewLayout
	
	@objc(initWithCollectionViewLayout:)
	public init(collectionViewLayout layout: UICollectionViewLayout) {
		collectionViewLayout = layout
		super.init(nibName: nil, bundle: nil)
	}
	
	public required init?(coder: NSCoder) {
		collectionViewLayout = UICollectionViewFlowLayout()
		super.init(nibName: nil, bundle: nil)
	}
	
	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		collectionViewLayout = UICollectionViewFlowLayout()
		super.init(nibName: nil, bundle: nil)
	}
	
	// MARK: - View Lifecycle
	
	open override func loadView() {
		super.loadView()
		
		let created = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
		created.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		created.delegate = self
		created.dataSource = self
		created.remembersLastFocusedIndexPath = true
		
		collectionView = created
		view.addSubview(created)
	}
	
	// MARK: - UICollectionView Delegate
	
	open func numberOfSections(in collectionView: UICollectionView) -> Int {
		0
	}
	
	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		0
	}
	
	/// Subclasses are expected to override this. The Objective-C original returned nil,
	/// which UICollectionView does not accept, so this returns a blank cell instead.
	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		UICollectionViewCell()
	}
	
}
