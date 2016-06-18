//
//  UINavigationBar+TKCategory.m
//  Created by Devin Ross on 3/4/14.
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

#import "UINavigationBar+TKCategory.h"

@implementation UINavigationBar (TKCategory)

- (UIView*) hairlineDividerView{
	return [self _harry:self];
}

- (UIImageView*) _harry:(UIView *)view {
	CGFloat diff = view.bounds.size.height - (1.0f / [UIScreen mainScreen].scale);
	
	if ([view isKindOfClass:UIImageView.class] && diff < 1.0f) {
		return (UIImageView *)view;
	}
	for (UIView *subview in view.subviews) {
		UIImageView *imageView = [self _harry:subview];
		if (imageView) {
			return imageView;
		}
	}
	return nil;
}

- (UIView*) _hairlineViewUnder:(UIView *)view {
	if (([view isKindOfClass:UIImageView.class] && CGRectGetHeight(view.bounds) == 0.5) || (CGRectGetHeight(view.frame) == 1)) {
		return view;
	}
	for (UIView *subview in view.subviews) {
		UIView *hairline = [self _hairlineViewUnder:subview];
		if (hairline) {
			return hairline;
		}
	}
	return nil;
}

@end