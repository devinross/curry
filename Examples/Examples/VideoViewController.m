//
//  VideoViewController.m
//  Created by Devin Ross on 6/26/15.
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

#import "VideoViewController.h"

@implementation VideoViewController

#pragma mark View Lifecycle
- (void) loadView{
	[super loadView];
	self.edgesForExtendedLayout = UIRectEdgeNone;
	self.title = NSLocalizedString(@"Video", @"");
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.videoViewController = [[TKVideoViewController alloc] initWithVideoTitle:@"balllin" ofType:@"mov"];
	self.videoViewController.view.frame = CGRectInset(self.view.bounds, 40, 60);
	[self.view addSubview:self.videoViewController.view];
}
- (void) viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[self.videoViewController play];
}
- (void) viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[self.videoViewController.player pause];
}


@end
