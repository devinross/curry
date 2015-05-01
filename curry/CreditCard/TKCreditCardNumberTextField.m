//
//  TKCreditCardNumberTextField.m
//  Created by Devin Ross on 4/10/15.
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
