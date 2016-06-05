//
//  UIScrollview+TKCategory.m
//  Created by Devin Ross on 11/17/10.
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
#import "UIScrollview+TKCategory.h"
#import "TKFoundation.h"
#import "TKUIKit.h"

@implementation UIScrollView (TKCategory)

- (void) scrollToTop{
	self.contentOffset = CGPointMake( -self.contentInset.left, -self.contentInset.top);
}

- (NSInteger) currentHorizontalPage{
	return (CGFrameGetWidth(self) / 2 + self.contentOffset.x) / CGFrameGetWidth(self);
}
- (NSInteger) currentVerticalPage{
	return (CGFrameGetHeight(self) / 2 + self.contentOffset.y) / CGFrameGetHeight(self);
}

- (CGPoint) contentOffsetFromEnd{
	CGFloat x = self.contentSize.width - self.contentOffset.x - CGFrameGetWidth(self);
	CGFloat y = self.contentSize.height - self.contentOffset.y - CGFrameGetHeight(self);
	
	if(self.contentSize.width < CGFrameGetWidth(self)){
		x = -self.contentOffset.x;
	}
	
	if(self.contentSize.height < CGFrameGetHeight(self)){
		y = -self.contentOffset.y;
	}
	
	return CGPointMake(x, y);
}


@end
