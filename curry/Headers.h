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

// Some categories now live in the CurrySwift module, which ships alongside this
// one in the `curry` package product. It cannot be re-exported from this
// umbrella header (a Swift module is not resolvable while Clang builds the
// `curry` module), so consumers import it directly:
//
//     @import CurrySwift;   // Objective-C
//     import CurrySwift     // Swift

// Categories -> Foundation


#if TARGET_OS_IOS || TARGET_OS_TV

#import "TKUIKit.h"



// Categories -> UIKit -> Base

// Categories -> UIKit -> Views
#import "UIView+Positioning.h"
#import "UIScrollView+Positioning.h"
#import "UIPanGestureRecognizer+VelocityDirection.h"
#import "UIView+GestureRecognizerBlock.h"
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
#import "UIControl+Blocks.h"

// Categories -> UIKit -> Controllers
#import "UIViewController+TKCategory.h"
#import "UIAlertController+TKCategory.h"
#if !TARGET_OS_TV
#import "UIImagePickerController+TKCategory.h"
#import "UIActionSheet+TKCategory.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+TKCategory.h"
#import "UIAlertView+Blocks.h"
#endif




// Categories -> UIKit -> Animations
#import "UIView+TKAnimation.h"

// ViewControllers
#import "TKCustomPresentationViewController.h"
#import "TKCardModalViewController.h"
#import "TKTableViewController.h"
#import "TKVideoViewController.h"
#import "TKCollectionViewController.h"
#if !TARGET_OS_TV
#import "TKKeyboardTableViewController.h"
#import "TKWebViewController.h"
#endif


#if !TARGET_OS_TV
// Views -> Keyboard
#import "TKInputView.h"
#import "TKInputKey.h"
#import "TKNumberInputView.h"
#import "TKDecimalInputView.h"
#import "TKNumberInputWithNextKeyView.h"
#import "TKDecimalInputWithNextKeyView.h"
#endif

// Views
#import "TKGradientView.h"
#import "TKShapeView.h"
#import "TKSectionedScrollView.h"
#import "TKCurrentTimeLabel.h"
#import "TKTextFieldCell.h"
#import "TKWindow.h"
#if !TARGET_OS_TV
#import "TKExtendedScrollView.h"
#import "TKSwitchCell.h"
#import "TKStepperCell.h"
#import "TKTextView.h"
#endif

// Custom Text Field
#import "TKCreditCardNumberTextField.h"
#import "TKCreditCardExpirationTextField.h"
#import "TKCreditCardZipTextField.h"
#import "TKCreditCardCVVTextField.h"
#import "TKPhoneNumberTextField.h"

// Extra
#import "TKSoundAlertController.h"
#if !TARGET_OS_TV
#import "TKSafariWebCredentials.h"
#endif


#endif // END TARGET_OS_IOS || TARGET_OS_TV


#if TARGET_OS_OSX
#import "NSView+Positioning.h"
#import "NSView+TKCategory.h"
#endif

#endif
