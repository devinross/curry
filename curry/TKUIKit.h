//
//  TKUIKit.h
//  Created by Devin Ross on 9/21/15.
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
@import QuartzCore;

UIKIT_STATIC_INLINE CATransform3D CAScale(CGFloat x,CGFloat y,CGFloat z);
UIKIT_STATIC_INLINE CATransform3D CAScale(CGFloat x,CGFloat y,CGFloat z){
	return CATransform3DMakeScale(x,y,z);
}

UIKIT_STATIC_INLINE CATransform3D CARotate(CGFloat angle,CGFloat x,CGFloat y,CGFloat z);
UIKIT_STATIC_INLINE CATransform3D CARotate(CGFloat angle,CGFloat x,CGFloat y,CGFloat z){
	return CATransform3DMakeRotation(angle,x,y,z);
}

UIKIT_STATIC_INLINE CATransform3D CATranslate(CGFloat x,CGFloat y,CGFloat z);
UIKIT_STATIC_INLINE CATransform3D CATranslate(CGFloat x,CGFloat y,CGFloat z){
	return CATransform3DMakeTranslation(x,y,z);
}

UIKIT_STATIC_INLINE CATransform3D CAConcat(CATransform3D t1,CATransform3D t2);
UIKIT_STATIC_INLINE CATransform3D CAConcat(CATransform3D t1,CATransform3D t2){
	return CATransform3DConcat(t1,t2);
}

UIKIT_STATIC_INLINE CGAffineTransform CGScale(CGFloat x,CGFloat y);
UIKIT_STATIC_INLINE CGAffineTransform CGScale(CGFloat x,CGFloat y){
	return CGAffineTransformMakeScale(x,y);
}

UIKIT_STATIC_INLINE CGAffineTransform CGRotate(CGFloat angle);
UIKIT_STATIC_INLINE CGAffineTransform CGRotate(CGFloat angle){
	return CGAffineTransformMakeRotation(angle);
}

UIKIT_STATIC_INLINE CGAffineTransform CGTranslate(CGFloat x, CGFloat y);
UIKIT_STATIC_INLINE CGAffineTransform CGTranslate(CGFloat x, CGFloat y){
	return CGAffineTransformMakeTranslation(x, y);
}

UIKIT_STATIC_INLINE CGAffineTransform CGConcat(CGAffineTransform first, CGAffineTransform second);
UIKIT_STATIC_INLINE CGAffineTransform CGConcat(CGAffineTransform first, CGAffineTransform second){
	return CGAffineTransformConcat(first, second);
}

UIKIT_STATIC_INLINE CGRect CGRectMakeWithSize(CGFloat x, CGFloat y, CGSize size);
UIKIT_STATIC_INLINE CGRect CGRectMakeWithSize(CGFloat x, CGFloat y, CGSize size){
	CGRect r; r.origin.x = x; r.origin.y = y; r.size = size; return r;
}

UIKIT_STATIC_INLINE CGRect CGRectMakeWithPoint(CGPoint origin, CGFloat width, CGFloat height);
UIKIT_STATIC_INLINE CGRect CGRectMakeWithPoint(CGPoint origin, CGFloat width, CGFloat height){
	CGRect r; r.origin = origin; r.size.width = width; r.size.height = height; return r;
}

UIKIT_STATIC_INLINE CGRect CGRectCompose(CGPoint origin, CGSize size);
UIKIT_STATIC_INLINE CGRect CGRectCompose(CGPoint origin, CGSize size){
	CGRect r; r.origin = origin; r.size = size; return r;
}

UIKIT_STATIC_INLINE CGRect CGRectMakeInset(CGFloat x, CGFloat y, CGFloat width, CGFloat height, CGFloat dx, CGFloat dy);
UIKIT_STATIC_INLINE CGRect CGRectMakeInset(CGFloat x, CGFloat y, CGFloat width, CGFloat height, CGFloat dx, CGFloat dy){
	return CGRectInset(CGRectMake(x,y,width,height), dx, dy);
}



UIKIT_STATIC_INLINE CGRect CGRectInsetX(CGRect rect, CGFloat dx);
UIKIT_STATIC_INLINE CGRect CGRectInsetX(CGRect rect, CGFloat dx){
	return CGRectInset(rect, dx, 0);
}

UIKIT_STATIC_INLINE CGRect CGRectInsetY(CGRect rect, CGFloat dy);
UIKIT_STATIC_INLINE CGRect CGRectInsetY(CGRect rect, CGFloat dy){
	return CGRectInset(rect, 0, dy);
}

UIKIT_STATIC_INLINE CGRect CGRectCenteredInRect(CGRect parentRect, CGFloat width, CGFloat height);
UIKIT_STATIC_INLINE CGRect CGRectCenteredInRect(CGRect parentRect, CGFloat width, CGFloat height){
	CGFloat minX = CGRectGetMinX(parentRect) + round((CGRectGetWidth(parentRect) - width) / 2);
	CGFloat minY = CGRectGetMinY(parentRect) + round((CGRectGetHeight(parentRect) - height) / 2);
	return CGRectMake(minX, minY, width, height);
}

UIKIT_STATIC_INLINE CGRect CGRectCenteredXInRect(CGRect parentRect, CGFloat originY, CGFloat width, CGFloat height);
UIKIT_STATIC_INLINE CGRect CGRectCenteredXInRect(CGRect parentRect, CGFloat originY, CGFloat width, CGFloat height){
	CGFloat minX = CGRectGetMinX(parentRect) + round((CGRectGetWidth(parentRect) - width) / 2);
	return CGRectMake(minX, originY, width, height);
}

UIKIT_STATIC_INLINE CGRect CGRectCenteredYInRect(CGRect parentRect, CGFloat originX, CGFloat width, CGFloat height);
UIKIT_STATIC_INLINE CGRect CGRectCenteredYInRect(CGRect parentRect, CGFloat originX, CGFloat width, CGFloat height){
	CGFloat minY = CGRectGetMinY(parentRect) + round((CGRectGetHeight(parentRect) - height) / 2);
	return CGRectMake(originX, minY, width, height);
}




UIKIT_STATIC_INLINE CGRect CGRectCenteredInRectWithSize(CGRect parentRect, CGSize size);
UIKIT_STATIC_INLINE CGRect CGRectCenteredInRectWithSize(CGRect parentRect, CGSize size){
	CGFloat minX = CGRectGetMinX(parentRect) + round((CGRectGetWidth(parentRect) - size.width) / 2);
	CGFloat minY = CGRectGetMinY(parentRect) + round((CGRectGetHeight(parentRect) - size.height) / 2);
	return CGRectMakeWithSize(minX, minY, size);
}

UIKIT_STATIC_INLINE CGRect CGRectCenteredXInRectWithSize(CGRect parentRect, CGFloat originY, CGSize size);
UIKIT_STATIC_INLINE CGRect CGRectCenteredXInRectWithSize(CGRect parentRect, CGFloat originY, CGSize size){
	CGFloat minX = CGRectGetMinX(parentRect) + round((CGRectGetWidth(parentRect) - size.width) / 2);
	return CGRectMakeWithSize(minX, originY, size);
}

UIKIT_STATIC_INLINE CGRect CGRectCenteredYInRectWithSize(CGRect parentRect, CGFloat originX, CGSize size);
UIKIT_STATIC_INLINE CGRect CGRectCenteredYInRectWithSize(CGRect parentRect, CGFloat originX, CGSize size){
	CGFloat minY = CGRectGetMinY(parentRect) + round((CGRectGetHeight(parentRect) - size.height) / 2);
	return CGRectMakeWithSize(originX, minY, size);
}





UIKIT_STATIC_INLINE CGPoint CGPointGetMidpoint(CGPoint p1,CGPoint p2);
UIKIT_STATIC_INLINE CGPoint CGPointGetMidpoint(CGPoint p1,CGPoint p2){
	return CGPointMake((p1.x+p2.x)/2.0f,(p1.y+p2.y)/2.0f);
}

UIKIT_STATIC_INLINE CGFloat CGPointGetDistance(CGPoint p1,CGPoint p2);
UIKIT_STATIC_INLINE CGFloat CGPointGetDistance(CGPoint p1,CGPoint p2){
	return sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2));
}


UIKIT_STATIC_INLINE CGPoint CGRectGetMidpoint(CGRect rect);
UIKIT_STATIC_INLINE CGPoint CGRectGetMidpoint(CGRect rect){
	return CGPointMake(rect.origin.x + rect.size.width / 2.0f, rect.origin.y + rect.size.height / 2.0f);
}

UIKIT_STATIC_INLINE CGPoint CGRectGetCenter(CGRect rect);
UIKIT_STATIC_INLINE CGPoint CGRectGetCenter(CGRect rect){
	return CGPointMake(rect.size.width / 2.0f, rect.size.height / 2.0f);
}


UIKIT_STATIC_INLINE CGFloat CGFrameGetWidth(UIView *view);
UIKIT_STATIC_INLINE CGFloat CGFrameGetWidth(UIView *view){
	return CGRectGetWidth(view.frame);
}

UIKIT_STATIC_INLINE CGFloat CGFrameGetHeight(UIView *view);
UIKIT_STATIC_INLINE CGFloat CGFrameGetHeight(UIView *view){
	return CGRectGetHeight(view.frame);
}

UIKIT_STATIC_INLINE CGFloat CGFrameGetMinX(UIView *view);
UIKIT_STATIC_INLINE CGFloat CGFrameGetMinX(UIView *view){
	return CGRectGetMinX(view.frame);
}
UIKIT_STATIC_INLINE CGFloat CGFrameGetMinY(UIView *view);
UIKIT_STATIC_INLINE CGFloat CGFrameGetMinY(UIView *view){
	return CGRectGetMinY(view.frame);
}

UIKIT_STATIC_INLINE CGFloat CGFrameGetMaxX(UIView *view);
UIKIT_STATIC_INLINE CGFloat CGFrameGetMaxX(UIView *view){
	return CGRectGetMaxX(view.frame);
}
UIKIT_STATIC_INLINE CGFloat CGFrameGetMaxY(UIView *view);
UIKIT_STATIC_INLINE CGFloat CGFrameGetMaxY(UIView *view){
	return CGRectGetMaxY(view.frame);
}

UIKIT_STATIC_INLINE CGFloat CGFrameGetMidX(UIView *view);
UIKIT_STATIC_INLINE CGFloat CGFrameGetMidX(UIView *view){
	return CGRectGetMidX(view.frame);
}
UIKIT_STATIC_INLINE CGFloat CGFrameGetMidY(UIView *view);
UIKIT_STATIC_INLINE CGFloat CGFrameGetMidY(UIView *view){
	return CGRectGetMidY(view.frame);
}

UIKIT_STATIC_INLINE NSValue* NSValueCATransform(CATransform3D transform);
UIKIT_STATIC_INLINE NSValue* NSValueCATransform(CATransform3D transform){
	return [NSValue valueWithCATransform3D:transform];
}

UIKIT_STATIC_INLINE NSValue* NSValueCGTransform(CGAffineTransform transform);
UIKIT_STATIC_INLINE NSValue* NSValueCGTransform(CGAffineTransform transform){
	return [NSValue valueWithCGAffineTransform:transform];
}
