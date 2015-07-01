//
//  UIAlertView+Blocks.h
//  Created by Devin Ross on 5/1/15.
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

@import UIKit;

/** Introduces block callbacks to `UIAlertView`. */
@interface UIAlertView (Blocks) <UIAlertViewDelegate>

/** Creates a `UIAlertView` with the given title and message and no buttons.
 @param title The title of the alert.
 @param message The message of the alert.
 @return A freshly minted `UIAlertView`.
 */
+ (UIAlertView*) alertWithTitle:(NSString*)title message:(NSString*)message;


/** Initializes a `UIAlertView` with the given title and message and no buttons.
 @param title The title of the alert.
 @param message The message of the alert.
 @return A freshly minted `UIAlertView`.
 */
- (instancetype) initWithTitle:(NSString *)title messsge:(NSString*)message;

/** Add a button with a callback block.
 @param title The title for the sheet.
 @param block The callback sent when a user selects the option.
 */
- (void) addButtonWithTitle:(NSString*)title handler:(void (^)(UIAlertView *sender))block;

/** Add a cancel button with a callback block.
 @param title The title for the sheet.
 @param block The callback sent when a user selects the option.
 */
- (void) addCancelButtonWithTitle:(NSString*)title handler:(void (^)(UIAlertView *sender))block;

@end