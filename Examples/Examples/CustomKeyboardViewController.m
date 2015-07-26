//
//  CustomKeyboardViewController.m
//  Examples
//
//  Created by Devin Ross on 5/26/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "CustomKeyboardViewController.h"

@interface CustomKeyboardViewController ()

@end

@implementation CustomKeyboardViewController

- (void) loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, CGFrameGetWidth(self.view), 100), 30, 20)];
	self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self.view addSubview:self.textField];
    
    TKNumberInputView *input = [[TKDecimalInputWithNextKeyView alloc] initWithFrame:CGRectMake(0, 0, CGFrameGetWidth(self.view), 216)];
    input.textField = self.textField;
    
    self.textField.inputView = input;

    
    
    
}

@end
