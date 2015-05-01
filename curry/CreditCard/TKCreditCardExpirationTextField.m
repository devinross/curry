//
//  TKCreditCardExpirationTextField.m
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
