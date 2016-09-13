//
//  ColorsViewController.swift
//  Examples
//
//  Created by Devin Ross on 9/12/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

import UIKit

class ColorsViewController: UIViewController {


	
	
	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.white
		
		
		let scrollView = UIScrollView(frame: self.view.bounds)
		self.view.addSubview(scrollView)
		
		let pad = CGFloat(20.0)
		let width = (self.view.width - (pad*4.0)) / 3.0
		let middleX = pad*2 + width
		let rightX = pad*3 + width*2
		
		
		let colors = [[UIColor(colorLiteralRed: 0, green: 121/255.0, blue: 210/255.0, alpha: 1),]]
		
		
		
		
		var middle = CGRect(x: middleX, y: pad, width: width, height: width)
		var left = CGRect(x:pad, y: pad, width: width, height: width)
		var right = CGRect(x:rightX, y: pad, width: width, height: width)
		
		for array in colors {
			
			
			let block1 = UIView(frame: left, backgroundColor: array.first!)
			scrollView.addSubview(block1)
			
			let block2 = UIView(frame: middle, backgroundColor: array[1])
			scrollView.addSubview(block2)
			
			let block3 = UIView(frame: right, backgroundColor: array.last!)
			scrollView.addSubview(block3)
			
			
			left.origin.y = block1.maxY + pad
			middle.origin.y = block1.maxY + pad;
			right.origin.y = block1.maxY + pad;

			
		}
		
		scrollView.contentHeight = right.origin.y
		
		
		
	}
	
	
	
	
	
//	- (void) loadView{
//	[super loadView];
//	self.view.backgroundColor = [UIColor whiteColor];
//	
//	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//	[self.view addSubview:scrollView];
//	
//	CGFloat pad = 20;
//	CGFloat width = (self.view.width - (pad*4)) / 3;
//	CGFloat middleX = pad*2 + width;
//	CGFloat rightX = pad*3 + width*2;
//	
//	NSArray *colors = @[ @[[UIColor colorWithRed:0 green:121/255.0f blue:210/255.0f alpha:1],[UIColor colorWithHex:0x0079d2],[UIColor colorWithHexString:@"#0079d2"]],
//	@[[UIColor colorWithRed:76/255.0f green:135/255.0f blue:179/255.0f alpha:1],[UIColor colorWithHex:0x4c87b3],[UIColor colorWithHexString:@"4c87b3"]],
//	@[[UIColor colorWithRed:84/255.0f green:107/255.0f blue:73/255.0f alpha:1],[UIColor colorWithHex:0x546B49],[UIColor colorWithHexString:@"0x546B49"]] ];
//	
//	CGRect middle = CGRectMake(middleX, pad, width, width);
//	CGRect left = CGRectMake(pad, pad, width, width);
//	CGRect right = CGRectMake(rightX, pad, width, width);
//	
//	for(NSArray *array in colors){
//	
//	UIView *block = [UIView viewWithFrame:left backgroundColor:array.firstObject];
//	[scrollView addSubview:block];
//	
//	block = [UIView viewWithFrame:middle backgroundColor:array[1]];
//	[scrollView addSubview:block];
//	
//	block = [UIView viewWithFrame:right backgroundColor:array.lastObject];
//	[scrollView addSubview:block];
//	
//	
//	right.origin.y = middle.origin.y = left.origin.y = block.maxY+pad;
//	
//	}
//	
//	scrollView.contentHeight = right.origin.y;
//	
//	
//	
//	
//	
//	
//	}

}
