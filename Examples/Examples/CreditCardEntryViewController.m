//
//  CreditCardEntryViewController.m
//  Examples
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "CreditCardEntryViewController.h"

@interface CreditCardEntryViewController ()

@end

@implementation CreditCardEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
