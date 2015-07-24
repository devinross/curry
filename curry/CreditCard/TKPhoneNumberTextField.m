//
//  TKPhoneNumberTextField.m
//  curry
//
//  Created by Devin Ross on 7/23/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "TKPhoneNumberTextField.h"
#import "NSString+TKCategory.h"

@implementation TKPhoneNumberTextField

- (id) initWithFrame:(CGRect)frame{
	if(!(self=[super initWithFrame:frame])) return nil;
	
	self.placeholder = NSLocalizedString(@"Phone Number", @"");
	self.keyboardType = UIKeyboardTypeNumberPad;
	self.autocorrectionType = UITextAutocorrectionTypeNo;
	[self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	
	return self;
}


- (void) textFieldDidChange:(id)sender{
	self.text = [self.text formattedPhoneNumberWithLastCharacterRemoved:NO];
	
}

@end
