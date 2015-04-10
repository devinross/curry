//
//  UIView+Material.h
//  curry
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

@import UIKit;
@import QuartzCore;

@interface UIView (Material)

#pragma mark Material Like Animations



- (void) fireMaterialTouchDiskAtPoint:(CGPoint)point;
- (void) materialTransitionWithSubview:(UIView*)subview atPoint:(CGPoint)point changes:(void (^)(void))changes completion:(void (^)(BOOL finished))completion;
- (void) materialTransitionWithSubview:(UIView*)subview expandCircle:(BOOL)expandCircle atPoint:(CGPoint)point duration:(CFTimeInterval)duration changes:(void (^)(void))changes completion:(void (^)(BOOL finished))completion;


@end
