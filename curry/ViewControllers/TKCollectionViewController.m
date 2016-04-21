//
//  TKCollectionViewController.m
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

#import "TKCollectionViewController.h"

@implementation TKCollectionViewController

- (instancetype) initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
	if(!(self=[super initWithNibName:nil bundle:nil])) return nil;
	_collectionViewLayout = layout;
	return self;
}
- (instancetype) initWithCoder:(NSCoder *)aDecoder{
	return [self initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
}
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	return [self initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
}

#pragma mark View Lifecycle
- (void) loadView{
	[super loadView];
	
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewLayout];
	self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	
#ifndef SDK_HIDE_TIDE
	if([self.collectionView respondsToSelector:@selector(remembersLastFocusedIndexPath)])
		self.collectionView.remembersLastFocusedIndexPath = YES;
#endif
	[self.view addSubview:self.collectionView];
	
}

#pragma mark UICollectionView Delegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 0;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 0;
}
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	return nil;
}

@end
