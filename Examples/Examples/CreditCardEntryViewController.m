//
//  CreditCardEntryViewController.m
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

#import "CreditCardEntryViewController.h"

@implementation CreditCardEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.numberField = [[TKCreditCardNumberTextField alloc] initWithFrame:CGRectMake(20, 100, CGFrameGetWidth(self.view)-40, 60)];
    self.numberField.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [self.view addSubview:self.numberField];
    
    self.expirationField = [[TKCreditCardExpirationTextField alloc] initWithFrame:CGRectMake(20, CGFrameGetMaxY(self.numberField)+30, CGFrameGetWidth(self.view)-40, 60)];
    self.expirationField.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [self.view addSubview:self.expirationField];
    
    self.zipField = [[TKCreditCardZipTextField alloc] initWithFrame:CGRectMake(20, CGFrameGetMaxY(self.expirationField)+30, CGFrameGetWidth(self.view)-40, 60)];
    self.zipField.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [self.view addSubview:self.zipField];
    
    self.cvvField = [[TKCreditCardCVVTextField alloc] initWithFrame:CGRectMake(20, CGFrameGetMaxY(self.zipField)+30, CGFrameGetWidth(self.view)-40, 60)];
    self.cvvField.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [self.view addSubview:self.cvvField];
    
}




@end
