//
//  Header.h
//  curry
//
//  Created by Devin Ross on 9/9/15.
//  Copyright © 2015 Devin Ross. All rights reserved.
//

#ifndef Header_h
#define Header_h


#import "TKFoundation.h"
#import "TKUIKit.h"

// Categories -> Foundation
#import "NSObject+JSON.h"
#import "NSObject+TKCategory.h"
#import "NSString+TKCategory.h"
#import "NSArray+TKCategory.h"
#import "NSDate+TKCategory.h"
#import "NSMutableArray+TKCategory.h"
#import "NSAttributedString+TKCategory.h"
#import "NSMutableAttributedString+TKCategory.h"
#import "NSBundle+TKCategory.h"
#import "NSURLSession+TKCategory.h"
#import "NSTimer+Blocks.h"

// Categories -> UIKit -> Base
#import "UIApplication+TKCategory.h"
#import "UIDevice+TKCategory.h"
#import "UIScreen+TKCategory.h"

// Categories -> UIKit -> Views
#import "UIView+Positioning.h"
#import "UIView+TKCategory.h"
#import "UIScrollView+Positioning.h"
#import "UIScrollview+TKCategory.h"
#import "UILabel+TKCategory.h"
#import "UITextField+TKCategory.h"
#import "UIImageView+TKCategory.h"
#import "UIButton+TKCategory.h"
#import "UINavigationBar+TKCategory.h"
#import "UIBarButtonItem+TKCategory.h"
#import "UIView+Initializers.h"
#import "UILabel+Initializers.h"

// Categories -> UIKit -> Elements
#import "UIImage+TKCategory.h"
#import "UIFont+TKCategory.h"
#import "UIColor+TKCategory.h"
#import "UIGestureRecognizer+TKCategory.h"
#import "UIGestureRecognizer+Blocks.h"
#import "UIControl+Blocks.h"

// Categories -> UIKit -> Controllers
#import "UIViewController+TKCategory.h"



// Categories -> UIKit -> Animations
#import "UIView+TKAnimation.h"
#import "CALayer+TKAnimation.h"
#import "CAKeyframeAnimation+TKAnimation.h"
#import "CAAnimation+TKAnimation.h"
#import "UIGestureRecognizer+Blocks.h"

// ViewControllers
#import "TKCustomPresentationViewController.h"
#import "TKCardModalViewController.h"
#import "TKVideoViewController.h"
#import "TKCollectionViewController.h"
#import "TKTableViewController.h"


// Views
#import "TKGradientView.h"
#import "TKShapeView.h"
#import "TKSectionedScrollView.h"
#import "TKCurrentTimeLabel.h"
#import "TKTextFieldCell.h"


// Custom Text Field
#import "TKCreditCardNumberTextField.h"
#import "TKCreditCardExpirationTextField.h"
#import "TKCreditCardZipTextField.h"
#import "TKCreditCardCVVTextField.h"
#import "TKPhoneNumberTextField.h"

// Extra
#import "TKSoundAlertController.h" //sound

#endif /* Header_h */
