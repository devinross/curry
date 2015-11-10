//
//  Header.h
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
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

#ifndef curry_Header_h
#define curry_Header_h


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
#import "NSUserDefaults+iCloud.h"

// Categories -> UIKit -> Base
#import "UIApplication+TKCategory.h"
#import "UIDevice+TKCategory.h"
#import "UIScreen+TKCategory.h"
#import "UITraitCollection+TKCategory.h"

// Categories -> UIKit -> Views
#import "UIView+Positioning.h"
#import "UIScrollView+Positioning.h"
#import "UIPanGestureRecognizer+VelocityDirection.h"
#import "UIView+GestureRecognizerBlock.h"
#import "UIView+TKCategory.h"
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
#import "UIMotionEffectGroup+TKCategory.h"

// Categories -> UIKit -> Controllers
#import "UIImagePickerController+TKCategory.h"
#import "UIViewController+TKCategory.h"
#import "UIActionSheet+TKCategory.h"
#import "UIAlertView+TKCategory.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "UIAlertController+TKCategory.h"



// Categories -> UIKit -> Animations
#import "UIView+TKAnimation.h"
#import "CALayer+TKAnimation.h"
#import "CAKeyframeAnimation+TKAnimation.h"
#import "CAAnimation+TKAnimation.h"
#import "UIGestureRecognizer+Blocks.h"

// ViewControllers
#import "TKCustomPresentationViewController.h"
#import "TKCardModalViewController.h"
#import "TKTableViewController.h"
#import "TKKeyboardTableViewController.h"
#import "TKWebViewController.h"
#import "TKVideoViewController.h"
#import "TKCollectionViewController.h"

// Views -> Keyboard
#import "TKInputView.h"
#import "TKInputKey.h"
#import "TKNumberInputView.h"
#import "TKDecimalInputView.h"
#import "TKNumberInputWithNextKeyView.h"
#import "TKDecimalInputWithNextKeyView.h"

// Views
#import "TKGradientView.h"
#import "TKShapeView.h"
#import "TKExtendedScrollView.h"
#import "TKSectionedScrollView.h"
#import "TKCurrentTimeLabel.h"
#import "TKSwitchCell.h"
#import "TKStepperCell.h"
#import "TKTextFieldCell.h"
#import "TKWindow.h"
#import "TKTextView.h"

// Custom Text Field
#import "TKCreditCardNumberTextField.h"
#import "TKCreditCardExpirationTextField.h"
#import "TKCreditCardZipTextField.h"
#import "TKCreditCardCVVTextField.h"
#import "TKPhoneNumberTextField.h"

// Extra
#import "TKSoundAlertController.h"


#endif