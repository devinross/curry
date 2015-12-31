//
//  TKTableViewController.h
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


@import UIKit;

/**
 This class provides basic `UITableViewController` functionality under the `TKViewController` class.
 
 The key differences between `TKTableViewController` and `UITableViewController`:
 - The `UITableView` is a subview of the base view.
 - The content offset of the `UITableView` is remembered if the view is ever deconstructed by a memory warning.
 - Built to easily allocate and handle an empty view and search functionality.
 
 */

@interface TKTableViewController : UIViewController
#if TARGET_OS_TV
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
#else
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>
#endif




/** Initializes a table-view controller to manage a table view of a given style.
 @param style A constant that specifies the style of table view that the controller object is to manage (`UITableViewStylePlain` or `UITableViewStyleGrouped`).
 @return An initialized `TKTableViewController` object or nil if the object couldn’t be created.
 */
- (instancetype) initWithStyle:(UITableViewStyle)style;



///----------------------------
/// @name Properties
///----------------------------

/** Returns the table view managed by the controller object. */
@property (nonatomic,strong) UITableView *tableView;

/** Returns the table view style. */
@property (nonatomic,readonly) UITableViewStyle style;



#if TARGET_OS_IOS

/** Returns a `UISearchBar` view. */
@property (nonatomic,strong) UISearchBar *searchBar;

/** Returns a `UISearchDisplayController` for the search bar and table view. */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic,strong) UISearchDisplayController *searchBarDisplayController;
#pragma clang diagnostic pop


@property (nonatomic,strong) UISearchController *searchController;

#endif

/** The default value of this property is YES. When YES, the table view controller clears the table’s current selection when it receives a viewWillAppear: message. Setting this property to NO preserves the selection. */
@property (nonatomic,assign) BOOL clearsSelectionOnViewWillAppear;


@end
