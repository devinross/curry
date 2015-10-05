//
//  TKCardModalViewController.h
//  Created by Devin Ross on 10/13/14.
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
#import "TKCustomPresentationViewController.h"

/** `TKCardModalViewController` is a custom presented `UIViewController`
 *  with a main white card view that drops in and can be easily dismissed
 *  similiar to a `UIAlertView`.
 */
@interface TKCardModalViewController : TKCustomPresentationViewController <UICollisionBehaviorDelegate>

/** The main card view that appears that content should be placed on. */
@property (nonatomic,strong) UIView *contentView;

/** The background view that appears behind the content view. Place and snapshots or backdrops here. */
@property (nonatomic,strong) UIView *backgroundView;

/** Flag that allows the the user to throw the card off to dismiss it. Default is TRUE. */
@property (nonatomic,assign) BOOL throwToDismissEnabled;

/** Flag to enabled tap to dismiss the card. Default is TRUE. */
@property (nonatomic,assign) BOOL tapToDismissEnabled;

/** Flag to only allow the user to tap off the card and not on the contentView itself. Default is FALSE. */
@property (nonatomic,assign) BOOL onlyAllowTapOffCardToDismiss;

/** If a keyboard is displayed. The visible frame will adjust. */
@property (nonatomic,assign) CGRect visibleFrame;

/** The velocity from a pan gesture on the card. */
@property (nonatomic,assign) CGPoint velocity;

/** The animator that controls the card physics animation. */
@property (nonatomic,strong) UIDynamicAnimator *animator;

/** The animator that controls the card physics animation. */
@property (nonatomic,strong) UIAttachmentBehavior* attachmentBehavior;

/** The push behavior from the velocity of the pan gesture. */
@property (nonatomic,strong) UIPushBehavior *pushBehavior;

/** The item behavior of the card. */
@property (nonatomic,strong) UIDynamicItemBehavior *itemBehavior;


- (void) interactiveDismissalWithGesture:(UIPanGestureRecognizer*)gesture;

/** A notification callback that a keyboard will be shown.
 @param notification The `NSNotification` sender.
 */
- (void) keyboardWillShow:(NSNotification*)notification;

/** A notification callback that a keyboard will hide.
 @param notification The `NSNotification` sender.
 */
- (void) keyboardWillHide:(NSNotification*)notification;

/** This will present the view controller */
- (void) show;

/** This will hide the view controller. */
- (void) hide;

/** The function called when a tap gesture is called. For subclassing.
 @param sender The `UITapGestureRecognizer` sender.
 */
- (void) tapped:(UITapGestureRecognizer*)sender;

/** The function called when a pan gesture is called. For subclassing.
 @param gesture The `UIPanGestureRecognizer` sender.
 */
- (void) pan:(UIPanGestureRecognizer*)gesture;

@end
