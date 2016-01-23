//
//  BrightnessViewController.m
//  Examples
//
//  Created by Devin Ross on 1/23/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

#import "BrightnessViewController.h"

@interface BrightnessViewController ()

@end

@implementation BrightnessViewController

- (void) loadView{
	[super loadView];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	
	button.frame = CGRectCenteredInRect(self.view.bounds, 200, 60);
	[button setTitle:NSLocalizedString(@"Lower Brightness",@"") forState:UIControlStateNormal];
	[button addTarget:self action:@selector(changeBrightness:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
}

- (void) changeBrightness:(UIButton*)sender{
	
	
	if(sender.tag == 0){
		
		sender.tag = 1;
		[[UIScreen mainScreen] setBrightness:0.2 duration:5];
		[sender setTitle:NSLocalizedString(@"Raise Brightness",@"") forState:UIControlStateNormal];

	}else{
		sender.tag = 0;

		[sender setTitle:NSLocalizedString(@"Lower Brightness",@"") forState:UIControlStateNormal];

		[[UIScreen mainScreen] setBrightness:1 duration:5];
		
	}
	
	
}

@end
