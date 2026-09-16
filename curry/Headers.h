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

// Some categories now live in the CurrySwift module, which ships alongside this
// one in the `curry` package product. It cannot be re-exported from this
// umbrella header (a Swift module is not resolvable while Clang builds the
// `curry` module), so consumers import it directly:
//
//     @import CurrySwift;   // Objective-C
//     import CurrySwift     // Swift

// Categories -> Foundation


#if TARGET_OS_IOS || TARGET_OS_TV

#import <curry/TKUIKit.h>



// Categories -> UIKit -> Base

// Categories -> UIKit -> Views


// Categories -> UIKit -> Elements

// Categories -> UIKit -> Controllers
#if !TARGET_OS_TV
#endif




// Categories -> UIKit -> Animations

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


#if TARGET_OS_OSX
#import "NSView+Positioning.h"
#import "NSView+TKCategory.h"
#endif

#endif
