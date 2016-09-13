//
//  RootTableViewController.m
//  Created by Devin Ross on 4/10/15.
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

#import "RootTableViewController.h"
#import "CustomTextEntryViewController.h"
#import "BlocksViewController.h"
#import "VideoViewController.h"
#import "PDFGeneratorViewController.h"
#import "ColorsViewController.h"

#import <Examples-Swift.h>


@implementation RootTableViewController

#define IDENTIFIER @"cellIdentifier"

- (void) viewDidLoad {
    [super viewDidLoad];
    self.items = @[@"Card Modal",@"Custom Text Fields",@"Gestures Blocks",@"Action Sheet Blocks",@"Custom Keyboards",@"Video View Controller",@"Screen Brightness",@"PDF Generation",@"Colors"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER];
    self.title = NSLocalizedString(@"Curry", @"");
}


#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *ctr;
    if(indexPath.row == 0){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        TKCardModalViewController *card = [[TKCardModalViewController alloc] init];
        [self presentViewController:card animated:YES completion:nil];
        return;
    }
	
    if(indexPath.row == 1)
        ctr = CustomTextEntryViewController.new;
    else if(indexPath.row == 2)
        ctr = GesturesViewController.new;
    else if(indexPath.row == 3)
        ctr = BlocksViewController.new;
    else if(indexPath.row == 4)
        ctr = CustomKeyboardViewController.new;
	else if(indexPath.row == 5)
		ctr = VideoViewController.new;
	else if(indexPath.row == 6)
		ctr = BrightnessViewController.new;
	else if(indexPath.row == 7)
		ctr = PDFGeneratorViewController.new;
	else if(indexPath.row == 8)
		ctr = ColorsViewController.new;
	
	

    [self.navigationController pushViewController:ctr animated:YES];
    
}


@end
