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

#import <curry/TKFoundation.h>

// Categories -> Foundation
#import <curry/NSObject+JSON.h>
#import <curry/NSObject+TKCategory.h>
#import <curry/NSString+TKCategory.h>
#import <curry/NSArray+TKCategory.h>
#import <curry/NSDate+TKCategory.h>
#import <curry/NSObject+DataHelper.h>
#import <curry/NSMutableArray+TKCategory.h>

#import <curry/NSURLSession+TKCategory.h>
#import <curry/NSURLSession+TKProgressDataTask.h>
#import <curry/NSURLRequest+TKCategory.h>
#import <curry/NSTimer+Blocks.h>

#if TARGET_OS_IOS || TARGET_OS_TV

#import <curry/TKUIKit.h>

#import <curry/NSString+TKUIKit.h>
#import <curry/NSAttributedString+TKCategory.h>
#import <curry/NSMutableAttributedString+TKCategory.h>
#import <curry/NSBundle+Receipts.h>
#import <curry/NSUserDefaults+iCloud.h>


// Categories -> UIKit -> Base
#import <curry/UIApplication+TKCategory.h>
#import <curry/UIScreen+TKCategory.h>
#import <curry/UITraitCollection+TKCategory.h>

// Categories -> UIKit -> Views
#import <curry/UIView+Positioning.h>
#import <curry/UIScrollView+Positioning.h>
#import <curry/UIPanGestureRecognizer+VelocityDirection.h>
#import <curry/UIView+GestureRecognizerBlock.h>
#import <curry/UIView+TKCategory.h>
#import <curry/UIScrollview+TKCategory.h>
#import <curry/UILabel+TKCategory.h>
#import <curry/UITextField+TKCategory.h>
#import <curry/UIImageView+TKCategory.h>
#import <curry/UIButton+TKCategory.h>
#import <curry/UINavigationBar+TKCategory.h>
#import <curry/UIBarButtonItem+TKCategory.h>
#import <curry/UIView+Initializers.h>
#import <curry/UILabel+Initializers.h>


// Categories -> UIKit -> Elements
#import <curry/UIImage+TKCategory.h>
#import <curry/UIFont+TKCategory.h>
#import <curry/UIColor+TKCategory.h>
#import <curry/UIGestureRecognizer+TKCategory.h>
#import <curry/UIGestureRecognizer+Blocks.h>
#import <curry/UIControl+Blocks.h>
#import <curry/UIMotionEffectGroup+TKCategory.h>

// Categories -> UIKit -> Controllers
#import <curry/UIViewController+TKCategory.h>
#import <curry/UIAlertController+TKCategory.h>
#if !TARGET_OS_TV
#import <curry/UIImagePickerController+TKCategory.h>
#import <curry/UIActionSheet+TKCategory.h>
#import <curry/UIActionSheet+Blocks.h>
#import <curry/UIAlertView+TKCategory.h>
#import <curry/UIAlertView+Blocks.h>
#endif




// Categories -> UIKit -> Animations
#import <curry/UIView+TKAnimation.h>
#import <curry/CALayer+TKAnimation.h>
#import <curry/CAKeyframeAnimation+TKAnimation.h>
#import <curry/CAAnimation+TKAnimation.h>
#import <curry/UIGestureRecognizer+Blocks.h>

// ViewControllers
#import <curry/TKCustomPresentationViewController.h>
#import <curry/TKCardModalViewController.h>
#import <curry/TKTableViewController.h>
#import <curry/TKVideoViewController.h>
#import <curry/TKCollectionViewController.h>
#if !TARGET_OS_TV
#import <curry/TKKeyboardTableViewController.h>
#import <curry/TKWebViewController.h>
#endif



#if !TARGET_OS_TV
// Views -> Keyboard
#import <curry/TKInputView.h>
#import <curry/TKInputKey.h>
#import <curry/TKNumberInputView.h>
#import <curry/TKDecimalInputView.h>
#import <curry/TKNumberInputWithNextKeyView.h>
#import <curry/TKDecimalInputWithNextKeyView.h>
#endif

// Views
#import <curry/TKGradientView.h>
#import <curry/TKShapeView.h>
#import <curry/TKSectionedScrollView.h>
#import <curry/TKCurrentTimeLabel.h>
#import <curry/TKTextFieldCell.h>
#import <curry/TKWindow.h>
#if !TARGET_OS_TV
#import <curry/TKExtendedScrollView.h>
#import <curry/TKSwitchCell.h>
#import <curry/TKStepperCell.h>
#import <curry/TKTextView.h>
#endif

// Custom Text Field
#import <curry/TKCreditCardNumberTextField.h>
#import <curry/TKCreditCardExpirationTextField.h>
#import <curry/TKCreditCardZipTextField.h>
#import <curry/TKCreditCardCVVTextField.h>
#import <curry/TKPhoneNumberTextField.h>

// Extra
#import <curry/TKSoundAlertController.h>
#if !TARGET_OS_TV
#import <curry/TKSafariWebCredentials.h>
#endif


#endif // END TARGET_OS_IOS || TARGET_OS_TV


#if TARGET_OS_X
#import <curry/NSView+Positioning.h>
#import <curry/NSView+TKCategory.h>
#endif

#endif
