//
//  TKCreditCardExpirationTextField.m
//  Examples
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "TKCreditCardExpirationTextField.h"

@implementation TKCreditCardExpirationTextField


- (instancetype) initWithFrame:(CGRect)frame{
    if(!(self=[super initWithFrame:frame])) return nil;
    
    self.placeholder = NSLocalizedString(@"MM / YY", @"");
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.autocorrectionType = UITextAutocorrectionTypeNo;

    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    return self;
}
- (void) textFieldDidChange:(id)sender{
    
    if([self.text hasSuffix:@" /"]){
        self.text = [self.text substringToIndex:1];
        return;
    }
    
    NSCharacterSet *nonDigitSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *txt = [[self.text componentsSeparatedByCharactersInSet:nonDigitSet] componentsJoinedByString:@""];
    NSString *month = self.month;
    NSString *year = self.year;

    if(year.length > 0){
        self.text = [month stringByAppendingFormat:@" / %@",year];
    }else if(month.length > 1){
        self.text = [month stringByAppendingString:@" / "];
    }else{
        self.text = txt;
    }

}

- (NSString*) month{
    NSCharacterSet *nonDigitSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *txt = [[self.text componentsSeparatedByCharactersInSet:nonDigitSet] componentsJoinedByString:@""];
    return [txt substringToIndex:MIN(txt.length, 2)];
}
- (NSString*) year{
    NSCharacterSet *nonDigitSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *txt = [[self.text componentsSeparatedByCharactersInSet:nonDigitSet] componentsJoinedByString:@""];
    if(txt.length<3) return nil;
    NSString *afterMonth = [txt substringFromIndex:2];
    return [afterMonth substringToIndex:MIN(2,afterMonth.length)];
}



@end
