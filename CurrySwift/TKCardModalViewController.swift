//
//  TKCardModalViewController.swift
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

import UIKit


/// Tuning constants for the throw-to-dismiss physics.
private let resistance: CGFloat = 0.0                    // linear resistance applied to the card's dynamic item behavior
private let density: CGFloat = 1.0                       // relative mass density applied to the card's dynamic item behavior
private let velocityFactor: CGFloat = 1.0                // affects how quickly the view is pushed out of the view
private let angularVelocityFactor: CGFloat = 1.0         // adjusts the amount of spin applied during a push force
private let minimumVelocityRequiredForPush: CGFloat = 50 // how much velocity is required for the push behavior to be applied


@objc(TKCardModalViewController)
open class TKCardModalViewController: TKCustomPresentationViewController, UICollisionBehaviorDelegate, UIGestureRecognizerDelegate {
	
	@objc open var contentView: UIView!
	@objc open var backgroundView: UIView!
	
	@objc open var throwToDismissEnabled: Bool = true {
		didSet { panGesture?.isEnabled = throwToDismissEnabled }
	}
	
	@objc open var tapToDismissEnabled: Bool = true {
		didSet { tapGesture?.isEnabled = tapToDismissEnabled }
	}
	
	@objc open var onlyAllowTapOffCardToDismiss: Bool = false
	@objc open var visibleFrame: CGRect = .zero
	@objc open var velocity: CGPoint = .zero
	
	@objc open var animator: UIDynamicAnimator?
	@objc open var attachmentBehavior: UIAttachmentBehavior?
	@objc open var pushBehavior: UIPushBehavior?
	@objc open var itemBehavior: UIDynamicItemBehavior?
	
	private var angle: CGFloat = 0
	private var magnitude: CGFloat = 0
	private var cardRestingPosition: CGPoint = .zero
	private var tapGesture: UITapGestureRecognizer?
	private var panGesture: UIPanGestureRecognizer?
	
	/// The physics are tuned for the phone; the iPad needs them damped down.
	private var isPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
	private var deviceVelocityScale: CGFloat { isPad ? 0.2 : 1.0 }
	private var deviceAngularScale: CGFloat { isPad ? 0.7 : 1.0 }
	
	// MARK: - View Lifecycle
	
	open override func loadView() {
		super.loadView()
		view.backgroundColor = .clear
		visibleFrame = view.bounds
		
		let background = UIView(frame: view.bounds)
		background.backgroundColor = UIColor(white: 0, alpha: 0.5)
		background.alpha = 0
		background.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		backgroundView = background
		view.addSubview(background)
		
		let size = CGSize(width: 280, height: 200)
		let card = UIView(frame: CGRect(x: ((view.frame.width - size.width) / 2).rounded(.down),
		                                y: ((view.frame.height - size.height) / 2).rounded(.down),
		                                width: size.width, height: size.height))
		card.backgroundColor = .white
		card.layer.shadowOffset = CGSize(width: 0, height: 1)
		card.layer.shadowColor = UIColor.black.cgColor
		card.layer.shadowRadius = 3
		card.layer.shadowOpacity = 0.1
		card.layer.cornerRadius = 8
		card.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
		contentView = card
		view.addSubview(card)
		
		let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
		pan.isEnabled = throwToDismissEnabled
		card.addGestureRecognizer(pan)
		panGesture = pan
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
		tap.isEnabled = tapToDismissEnabled
		tap.delegate = self
		view.addGestureRecognizer(tap)
		tapGesture = tap
		
		animator = UIDynamicAnimator(referenceView: view)
	}
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		
		#if !os(tvOS)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
		                                       name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
		                                       name: UIResponder.keyboardWillHideNotification, object: nil)
		#endif
	}
	
	open override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
		horizontal.maximumRelativeValue = 15
		horizontal.minimumRelativeValue = -15
		contentView.addMotionEffect(horizontal)
		
		let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
		vertical.maximumRelativeValue = 15
		vertical.minimumRelativeValue = -15
		contentView.addMotionEffect(vertical)
	}
	
	// MARK: - Keyboard Notifications
	
	#if !os(tvOS)
	
	@objc(keyboardWillShow:)
	open func keyboardWillShow(_ notification: Notification) {
		
		let keyFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
		
		var bounds = view.bounds
		bounds.origin.y = 20
		bounds.size.height -= keyFrame.height
		bounds.size.height -= 20
		visibleFrame = bounds
		
		UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: []) {
			self.contentView.frame.origin.y = ((bounds.height - self.contentView.frame.height) / 2 + 20).rounded(.down)
		}
	}
	
	@objc(keyboardWillHide:)
	open func keyboardWillHide(_ notification: Notification) {
		
		visibleFrame = view.bounds
		
		UIView.animate(withDuration: 0.9, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: []) {
			self.contentView.frame.origin.y = ((self.view.frame.height - self.contentView.frame.height) / 2).rounded(.down)
		}
	}
	
	#endif
	
	// MARK: - Gesture Actions
	
	open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		let point = touch.location(in: contentView.superview)
		if gestureRecognizer === tapGesture && contentView.frame.contains(point) { return false }
		return true
	}
	
	@objc(tapped:)
	open func tapped(_ sender: UITapGestureRecognizer) {
		
		guard onlyAllowTapOffCardToDismiss else {
			hide()
			return
		}
		
		let point = sender.location(in: contentView.superview)
		if !contentView.frame.contains(point) { hide() }
	}
	
	private var shouldSnapBack: Bool {
		let velocityAdjust = 10.0 * deviceVelocityScale
		let escapes = abs(velocity.x / velocityAdjust) > minimumVelocityRequiredForPush
			|| abs(velocity.y / velocityAdjust) > minimumVelocityRequiredForPush
		return !escapes
	}
	
	@objc(pan:)
	open func pan(_ gesture: UIPanGestureRecognizer) {
		
		guard throwToDismissEnabled, let view = gesture.view, let container = view.superview else { return }
		
		let point = gesture.location(in: container)
		let velocity = gesture.velocity(in: container)
		let magnitude = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2))
		let offset = UIOffset(horizontal: point.x - view.center.x, vertical: point.y - view.center.y)
		let origin = CGPoint(x: container.bounds.midX, y: container.bounds.midY)
		let angle = atan2(point.y - origin.y, point.x - origin.x)
		
		if gesture.began {
			
			cardRestingPosition = contentView.center
			animator?.removeAllBehaviors()
			
			let item = UIDynamicItemBehavior(items: [view])
			item.elasticity = 0
			item.friction = 0.2
			item.allowsRotation = true
			item.density = density
			item.resistance = resistance
			animator?.addBehavior(item)
			itemBehavior = item
			
			let attachment = UIAttachmentBehavior(item: view, offsetFromCenter: offset, attachedToAnchor: point)
			animator?.addBehavior(attachment)
			attachmentBehavior = attachment
		}
		
		attachmentBehavior?.anchorPoint = point
		
		if gesture.changed {
			self.angle = angle
			self.magnitude = magnitude
		}
		
		if gesture.state == .ended || gesture.state == .cancelled {
			
			animator?.removeAllBehaviors()
			self.velocity = gesture.velocity(in: self.view)
			
			if shouldSnapBack {
				snapBack(view: view)
			} else {
				interactiveDismissal(gesture: gesture)
			}
		}
	}
	
	@objc(interactiveDismissalWithGesture:)
	open func interactiveDismissal(gesture: UIPanGestureRecognizer) {
		
		guard let view = gesture.view, let container = view.superview else { return }
		
		let location = gesture.location(in: container)
		let boxLocation = gesture.location(in: view)
		let velocityAdjust = 10.0 * deviceVelocityScale
		
		let push = UIPushBehavior(items: [view], mode: .instantaneous)
		push.angle = 0
		push.magnitude = 0
		pushBehavior = push
		
		let offsetFromCenter = UIOffset(horizontal: boxLocation.x - view.bounds.midX,
		                                vertical: boxLocation.y - view.bounds.midY)
		let radius = sqrt(pow(offsetFromCenter.horizontal, 2) + pow(offsetFromCenter.vertical, 2))
		let pushVelocity = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2))
		
		// Angles needed for the angular velocity formula.
		let velocityAngle = atan2(velocity.y, velocity.x)
		var locationAngle = atan2(offsetFromCenter.vertical, offsetFromCenter.horizontal)
		if locationAngle > 0 { locationAngle -= .pi * 2 }
		
		// theta is the angle between the push vector and the component parallel to the radius,
		// so it is always positive. Angular velocity: w = (abs(V) * sin(theta)) / abs(r)
		let theta = abs(abs(velocityAngle) - abs(locationAngle))
		var angularVelocity = abs((abs(pushVelocity) * sin(theta)) / abs(radius))
		
		// Rotation direction depends on which corner was pushed relative to the centre.
		var direction: CGFloat = location.x < view.center.x ? -1 : 1
		if velocity.y < 0 { direction *= -1 }
		
		// Force applied nearer the edges gets more spin.
		let xRatioFromCenter = abs(offsetFromCenter.horizontal) / (view.frame.width / 2)
		let yRatioFromCenter = abs(offsetFromCenter.vertical) / (view.frame.height / 2)
		angularVelocity *= deviceAngularScale
		angularVelocity *= (xRatioFromCenter + yRatioFromCenter) / 2
		
		itemBehavior?.addAngularVelocity(angularVelocity * angularVelocityFactor * direction, for: view)
		
		push.pushDirection = CGVector(dx: (velocity.x / velocityAdjust) * velocityFactor,
		                              dy: (velocity.y / velocityAdjust) * velocityFactor)
		push.active = true
		animator?.addBehavior(push)
		
		var off = max(contentView.frame.height, contentView.frame.width) * 1.1
		off = max(off, 420)
		
		let collide = UICollisionBehavior(items: [view])
		collide.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsets(top: -off, left: -off, bottom: -off, right: -off))
		collide.collisionDelegate = self
		animator?.addBehavior(collide)
		
		let size = self.view.bounds.size
		collide.addBoundary(withIdentifier: "top" as NSString,
		                    from: CGPoint(x: -off, y: -off), to: CGPoint(x: size.width + off, y: -off))
		collide.addBoundary(withIdentifier: "left" as NSString,
		                    from: CGPoint(x: -off, y: -off), to: CGPoint(x: -off, y: size.height + off))
		collide.addBoundary(withIdentifier: "right" as NSString,
		                    from: CGPoint(x: size.width + off, y: -off), to: CGPoint(x: size.width + off, y: size.height + off))
		collide.addBoundary(withIdentifier: "bottom" as NSString,
		                    from: CGPoint(x: -off, y: size.height + off), to: CGPoint(x: size.width + off, y: size.height + off))
	}
	
	private func snapBack(view: UIView) {
		let snap = UISnapBehavior(item: view, snapTo: cardRestingPosition)
		snap.damping = 0.85
		animator?.addBehavior(snap)
	}
	
	// MARK: - Actions
	
	@objc open func show() {
		let window = UIApplication.shared.delegate?.window ?? nil
		window?.rootViewController?.present(self, animated: true, completion: nil)
	}
	
	@objc open func hide() {
		#if !os(tvOS)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		#endif
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: - Transitions
	
	open override func presentTransitionAnimation(_ transitionContext: UIViewControllerContextTransitioning,
	                                              containerView: UIView,
	                                              fromViewController: UIViewController?) {
		
		containerView.addSubview(view)
		view.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
		
		let originalX = contentView.center.x
		let originalMinX = contentView.frame.minX
		
		contentView.center = CGPoint(x: originalX, y: -300)
		contentView.transform = CGAffineTransform(rotationAngle: -10 * .pi / 180.0)
		
		UIView.animate(withDuration: 0.4) { self.backgroundView.alpha = 1 }
		
		UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0,
		               usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: []) {
			self.contentView.transform = .identity
			let y = ((self.visibleFrame.height - self.contentView.frame.height) / 2).rounded(.down)
			self.contentView.frame = CGRect(x: originalMinX, y: y,
			                                width: self.contentView.frame.width,
			                                height: self.contentView.frame.height)
		} completion: { _ in
			self.transitionEnded()
		}
	}
	
	open override func dismissTransitionAnimation(_ transitionContext: UIViewControllerContextTransitioning,
	                                              containerView: UIView,
	                                              toViewController: UIViewController?) {
		
		if contentView.superview != nil {
			
			if animator == nil {
				animator = UIDynamicAnimator(referenceView: view)
			}
			animator?.removeAllBehaviors()
			
			let gravity = UIGravityBehavior(items: [contentView!])
			gravity.magnitude = 3
			animator?.addBehavior(gravity)
			
			let behaviour = UIDynamicItemBehavior(items: [contentView!])
			behaviour.allowsRotation = true
			behaviour.friction = 0.5
			behaviour.addAngularVelocity(CGFloat.random(in: -10 ... 10) / 100.0, for: contentView)
			animator?.addBehavior(behaviour)
		}
		
		let thrown = pushBehavior != nil
		
		UIView.animate(withDuration: thrown ? 0.2 : 0.4, delay: thrown ? 0.0 : 0.4, options: []) {
			self.backgroundView.transform = .identity
			self.backgroundView.alpha = 0
		} completion: { _ in
			self.view.removeFromSuperview()
			self.transitionEnded()
		}
	}
	
	// MARK: - UICollisionBehaviorDelegate
	
	open func collisionBehavior(_ behavior: UICollisionBehavior,
	                            beganContactFor item1: UIDynamicItem,
	                            with item2: UIDynamicItem,
	                            at p: CGPoint) {
	}
	
	open func collisionBehavior(_ behavior: UICollisionBehavior,
	                            beganContactFor item: UIDynamicItem,
	                            withBoundaryIdentifier identifier: NSCopying?,
	                            at p: CGPoint) {
		animator?.removeAllBehaviors()
		contentView.removeFromSuperview()
		hide()
	}
	
}
