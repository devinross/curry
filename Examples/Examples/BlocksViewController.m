//
//  ActionSheetBlockViewController.m
//  Created by Devin Ross on 5/1/15.
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

#import "BlocksViewController.h"


@implementation BlocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rr = CGRectCenteredInRect(self.view.bounds, 100, 100);
    UIButton *button;
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(rr.origin.x, rr.origin.y, rr.size.width, 50);
    [button setTitle:@"Show Sheet" forState:UIControlStateNormal];
    [button addEventHandler:^(id sender) {
        UIActionSheet *sheet = [[UIActionSheet alloc] init];
        [sheet addButtonWithTitle:@"Action" handler:^(UIActionSheet *sender) { NSLog(@"Action"); }];
        [sheet addCancelButtonWithTitle:@"Cancel" handler:^(UIActionSheet *sender) { NSLog(@"Cancel"); }];
        [sheet showInView:self.view];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(rr.origin.x, rr.origin.y+50, rr.size.width, 50);
    [button setTitle:@"Show Alert" forState:UIControlStateNormal];
    [button addEventHandler:^(id sender) {
        UIAlertView *alert = [UIAlertView alertWithTitle:@"Alert" message:@"Message"];
        [alert addButtonWithTitle:@"Option 1" handler:^(UIAlertView *sender) { NSLog(@"Option 1"); }];
        [alert addCancelButtonWithTitle:@"Cancel" handler:^(UIAlertView *sender) { NSLog(@"Cancel"); }];
        [alert show];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

@end
