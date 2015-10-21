//
//  NSView+Positioning.m
//  Created by Devin Ross on 10/21/15.
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

#import "NSView+Positioning.h"
#import "NSView+TKCategory.h"

@implementation NSView (Positioning)


- (CGPoint) center{
	return self.layer.position;
}
- (void) setCenter:(CGPoint)point{
	self.layer.position = point;
}

- (CGPoint) convertCenterToView:(NSView*)view{
	return [self.superview convertPoint:self.center toView:view];
}
- (CGRect) convertFrameToView:(NSView*)view{
	return [self.superview convertRect:self.frame toView:view];
}

- (void) moveToView:(NSView*)view{
	self.center = [self convertCenterToView:view];
	[self removeFromSuperview];
	[view addSubview:self];
}
- (void) moveToBackOfView:(NSView*)view{
	self.center = [self convertCenterToView:view];
	[self removeFromSuperview];
	[view addSubviewToBack:self];
}

- (CGPoint) middle{
	return CGPointMake(self.width/2, self.height/2);
}

- (CGFloat) width{
	return NSWidth(self.frame);
}
- (void) setWidth:(CGFloat)width{
	NSRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat) height{
	return NSHeight(self.frame);
}
- (void) setHeight:(CGFloat)height{
	NSRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGSize) size{
	return self.frame.size;
}
- (void) setSize:(NSSize)size{
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (CGPoint) origin{
	return self.frame.origin;
}
- (void) setOrigin:(CGPoint)origin{
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}

- (CGFloat) minX{
	return NSMidX(self.frame);
}
- (void) setMinX:(CGFloat)minX{
	self.center = CGPointMake(minX+self.width/2, self.center.y);
}

- (CGFloat) minY{
	return NSMinY(self.frame);
}
- (void) setMinY:(CGFloat)minY{
	self.center = CGPointMake(self.center.x, minY+self.height/2);
}

- (CGFloat) midX{
	return NSMidX(self.frame);
}
- (void) setMidX:(CGFloat)midX{
	self.center = CGPointMake(midX, self.center.y);
}

- (CGFloat) midY{
	return NSMidY(self.frame);
}
- (void) setMidY:(CGFloat)midY{
	self.center = CGPointMake(self.center.x, midY);
}

- (CGFloat) maxX{
	return NSMaxX(self.frame);
}
- (void) setMaxX:(CGFloat)maxX{
	self.center = CGPointMake(maxX-self.width/2, self.center.y);
}

- (CGFloat) maxY{
	return NSMaxY(self.frame);
}
- (void) setMaxY:(CGFloat)maxY{
	self.center = CGPointMake(self.center.x, maxY-self.height/2);
}

- (CGFloat) originX{
	return NSMinX(self.frame);
}
- (void) setOriginX:(CGFloat)originX{
	self.frame = CGRectMake(originX, NSMinY(self.frame), self.width, self.height);
}

- (CGFloat) originY{
	return NSMinY(self.frame);
}
- (void) setOriginY:(CGFloat)originY{
	self.frame = CGRectMake(NSMinX(self.frame), originY, self.width, self.height);
}

- (CGFloat) centerX{
	return self.center.x;
}
- (void) setCenterX:(CGFloat)centerX{
	self.layer.position = CGPointMake(centerX, self.layer.position.y);
}

- (CGFloat) centerY{
	return self.center.y;
}
- (void) setCenterY:(CGFloat)centerY{
	self.center = CGPointMake(self.center.x, centerY);
}


@end
