//
//  TKCustomPresentationViewController.m
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

#import "TKCustomPresentationViewController.h"


@interface TKCustomPresentationViewController () <UIViewControllerTransitioningDelegate>
@end

@implementation TKCustomPresentationViewController

- (instancetype) init{
    if(!(self=[super init])) return nil;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    return self;
}

- (void) presentTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)viewController{
    
}
- (void) dismissTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView toViewController:(UIViewController*)viewController{
    
}

- (void) transitionEnded{
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
    self.transitionContext = nil;
}

#pragma mark UIViewControllerTransitioningDelegate
- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if(toViewController == self)
        [self presentTransitionAnimation:self.transitionContext containerView:[transitionContext containerView] fromViewController:fromViewController];
    else
        [self dismissTransitionAnimation:transitionContext containerView:[transitionContext containerView] toViewController:toViewController];
}
- (void) animationEnded:(BOOL)transitionCompleted {

}
- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (id <UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self == presented ? self : nil;
}
- (id <UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed{
    return self == dismissed ? self : nil;
}


@end