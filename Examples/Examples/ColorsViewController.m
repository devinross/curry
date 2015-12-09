//
//  ColorsViewController.m
//  Examples
//
//  Created by Devin Ross on 12/9/15.
//  Copyright © 2015 Devin Ross. All rights reserved.
//

#import "ColorsViewController.h"

@interface ColorsViewController ()

@end

@implementation ColorsViewController

- (void) loadView{
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:scrollView];
	
	CGFloat pad = 20;
	CGFloat width = (self.view.width - (pad*4)) / 3;
	CGFloat middleX = pad*2 + width;
	CGFloat rightX = pad*3 + width*2;

	NSArray *colors = @[ @[[UIColor colorWithRed:0 green:121/255.0f blue:210/255.0f alpha:1],[UIColor colorWithHex:0x0079d2],[UIColor colorWithHexString:@"#0079d2"]],
						 @[[UIColor colorWithRed:76/255.0f green:135/255.0f blue:179/255.0f alpha:1],[UIColor colorWithHex:0x4c87b3],[UIColor colorWithHexString:@"4c87b3"]],
						 @[[UIColor colorWithRed:84/255.0f green:107/255.0f blue:73/255.0f alpha:1],[UIColor colorWithHex:0x546B49],[UIColor colorWithHexString:@"0x546B49"]] ];
	
	CGRect middle = CGRectMake(middleX, pad, width, width);
	CGRect left = CGRectMake(pad, pad, width, width);
	CGRect right = CGRectMake(rightX, pad, width, width);

	for(NSArray *array in colors){
		
		UIView *block = [UIView viewWithFrame:left backgroundColor:array.firstObject];
		[scrollView addSubview:block];
		
		block = [UIView viewWithFrame:middle backgroundColor:array[1]];
		[scrollView addSubview:block];
		
		block = [UIView viewWithFrame:right backgroundColor:array.lastObject];
		[scrollView addSubview:block];
		
		
		right.origin.y = middle.origin.y = left.origin.y = block.maxY+pad;

	}
	
	scrollView.contentHeight = right.origin.y;
	
	

	
	
	
}

@end
