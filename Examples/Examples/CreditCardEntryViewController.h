//
//  CreditCardEntryViewController.h
//  Examples
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

@import UIKit;
@import curry;

@interface CreditCardEntryViewController : UIViewController

@property (nonatomic,strong) TKCreditCardNumberTextField *numberField;
@property (nonatomic,strong) TKCreditCardExpirationTextField *expirationField;
@property (nonatomic,strong) TKCreditCardZipTextField *zipField;
@property (nonatomic,strong) TKCreditCardCVVTextField *cvvField;


@end
