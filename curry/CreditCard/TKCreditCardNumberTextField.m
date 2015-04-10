//
//  TKCreditCardNumberTextField.m
//  Examples
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "TKCreditCardNumberTextField.h"
#import "NSString+TKCategory.h"

@implementation TKCreditCardNumberTextField

- (instancetype) initWithFrame:(CGRect)frame{
    if(!(self=[super initWithFrame:frame])) return nil;
    
    self.placeholder = NSLocalizedString(@"Card Number", @"");
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    return self;
}
- (void) textFieldDidChange:(id)sender{
    
    NSCharacterSet *inverseDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    NSString *txt = [[self.text componentsSeparatedByCharactersInSet:inverseDigits] componentsJoinedByString:@""];
    txt = [txt substringWithRange:NSMakeRange(0, MIN(txt.length,19))];
    BOOL isAmex = [txt.creditCardType hasPrefix:@"Amer"];
    
    NSString *newString = @"";
    NSInteger increment = 4;
    while (txt.length > 0) {
        NSString *subString = [txt substringToIndex:MIN(txt.length, increment)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == increment) {
            newString = [newString stringByAppendingString:@" "];
        }
        
        txt = [txt substringFromIndex:MIN(txt.length, increment)];
        if(isAmex && increment == 4){
            increment = 6;

        } else if(isAmex && increment == 6){
            increment = 5;

        }
    }
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    self.text = newString;
    
}
- (BOOL) isValidCreditCard{
    NSCharacterSet *inverseDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *txt = [[self.text componentsSeparatedByCharactersInSet:inverseDigits] componentsJoinedByString:@""];

    return txt.isValidCreditCardNumber;
    
}

@end
