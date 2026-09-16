//
//  TKCustomPresentationViewController.swift
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

import UIKit


/** `TKCustomPresentationViewController` is a view controller set up to make its own custom presentation and dismissal. */
@objc(TKCustomPresentationViewController)
open class TKCustomPresentationViewController: UIViewController, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
	
	/** The `UIViewControllerContextTransitioning` that governs the presentation and dismissal. */
	@objc open var transitionContext: UIViewControllerContextTransitioning?
	
	public init() {
		super.init(nibName: nil, bundle: nil)
		configure()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		configure()
	}
	
	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		configure()
	}
	
	private func configure() {
		modalPresentationStyle = .custom
		transitioningDelegate = self
	}
	
	// MARK: - For subclassing
	
	/** Subclass this method to create a custom presentation transition.
	@param transitionContext The context that governs the presentation.
	@param containerView The container view to place this view controller's view.
	@param fromViewController The parent view controller.
	*/
	@objc(presentTransitionAnimation:containerView:fromViewController:)
	open func presentTransitionAnimation(_ transitionContext: UIViewControllerContextTransitioning,
	                                     containerView: UIView,
	                                     fromViewController: UIViewController?) {
	}
	
	/** Subclass this method to create a custom dismissal transition.
	@param transitionContext The context that governs the dismissal.
	@param containerView The container view to place this view controller's view.
	@param toViewController The parent view controller.
	*/
	@objc(dismissTransitionAnimation:containerView:toViewController:)
	open func dismissTransitionAnimation(_ transitionContext: UIViewControllerContextTransitioning,
	                                     containerView: UIView,
	                                     toViewController: UIViewController?) {
	}
	
	/** Call this method upon completion of the presentation and dismissal animations. */
	@objc open func transitionEnded() {
		transitionContext?.completeTransition(!(transitionContext?.transitionWasCancelled ?? false))
		transitionContext = nil
	}
	
	// MARK: - UIViewControllerAnimatedTransitioning
	
	open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		
		self.transitionContext = transitionContext
		
		let toViewController = transitionContext.viewController(forKey: .to)
		let fromViewController = transitionContext.viewController(forKey: .from)
		
		if toViewController === self {
			presentTransitionAnimation(transitionContext, containerView: transitionContext.containerView, fromViewController: fromViewController)
		} else {
			dismissTransitionAnimation(transitionContext, containerView: transitionContext.containerView, toViewController: toViewController)
		}
	}
	
	open func animationEnded(_ transitionCompleted: Bool) {
	}
	
	open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		0.8
	}
	
	// MARK: - UIViewControllerTransitioningDelegate
	
	open func animationController(forPresented presented: UIViewController,
	                              presenting: UIViewController,
	                              source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		self === presented ? self : nil
	}
	
	open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		self === dismissed ? self : nil
	}
	
}
