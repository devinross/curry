//
//  TKCreditCardCVVTextField.m
//  Examples
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "TKCreditCardCVVTextField.h"

@implementation TKCreditCardCVVTextField

- (instancetype) initWithFrame:(CGRect)frame{
    if(!(self=[super initWithFrame:frame])) return nil;
    
    self.placeholder = NSLocalizedString(@"CVV", @"");
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    return self;
}
- (void) textFieldDidChange:(id)sender{
    
    NSCharacterSet *nonDigitSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *txt = [[self.text componentsSeparatedByCharactersInSet:nonDigitSet] componentsJoinedByString:@""];
    self.text = [txt substringToIndex:MIN(4,txt.length)];
    
}

@end
