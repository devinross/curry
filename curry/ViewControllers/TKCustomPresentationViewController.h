//
//  TKCustomPresentationViewController.h
//  Created by Devin Ross on 4/23/15.
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

/** `TKCustomPresentationViewController` is view controller setup to make its own custom presentation and dismissal. */
@interface TKCustomPresentationViewController : UIViewController <UIViewControllerAnimatedTransitioning>

/** The `UIViewControllerContextTransitioning` that governs the presentation and dismissal. */
@property (nonatomic,strong) id<UIViewControllerContextTransitioning> transitionContext;

// For subclassing implementaion
/** Subclass this method to create a custom presentation transition.
 @param transitionContext The `UIViewControllerContextTransitioning` that governs the presentation.
 @param containerView The container view to place this view controller's view.
 @param fromViewController The parent view controller.
 */
- (void) presentTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController;

/** Subclass this method to create a custom dismissal transition.
 @param transitionContext The `UIViewControllerContextTransitioning` that governs the presentation.
 @param containerView The container view to place this view controller's view.
 @param toViewController The parent view controller.
 */
- (void) dismissTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView toViewController:(UIViewController*)toViewController;

/** The duration of the transition.
 @param transitionContext The `UIViewControllerContextTransitioning` that governs the presentation.
 @return The time of the transition.
 */
- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

/** Call this method upon completion of the presentation and dismissal animations. */
- (void) transitionEnded;

@end
