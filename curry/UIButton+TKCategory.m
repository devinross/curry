//
//  UIImage+TKButton.m
//  Created by Devin Ross on 1/9/11.
//
/*
 
 tapku || http://github.com/devinross/tapkulibrary
 
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



#import "UIButton+TKCategory.h"


@implementation UIButton (TKCategory)


+ (instancetype) buttonWithFrame:(CGRect)frame{
	return [[self class] buttonWithFrame:frame title:nil];
}
+ (instancetype) buttonWithFrame:(CGRect)frame title:(NSString*)title{
	return [[self class] buttonWithFrame:frame title:title backgroundImage:nil];
}
+ (instancetype) buttonWithFrame:(CGRect)frame title:(NSString*)title backgroundImage:(UIImage*)backgroundImage{
	return [[self class] buttonWithFrame:frame title:title backgroundImage:backgroundImage highlightedBackgroundImage:nil];
}
+ (instancetype) buttonWithFrame:(CGRect)frame title:(NSString*)title backgroundImage:(UIImage*)backgroundImage highlightedBackgroundImage:(UIImage*)highlightedBackgroundImage{
	UIButton *btn = [[self class] buttonWithType:UIButtonTypeCustom];
	btn.frame = frame;
	[btn setTitle:title forState:UIControlStateNormal];
	[btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
	[btn setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
	return btn;
}

+ (instancetype) buttonWithFrame:(CGRect)frame image:(UIImage*)image{
	return [[self class] buttonWithFrame:frame image:image highlightedImage:nil];
}
+ (instancetype) buttonWithFrame:(CGRect)frame image:(UIImage*)image highlightedImage:(UIImage*)highlightedImage{
	UIButton *btn = [[self class] buttonWithType:UIButtonTypeCustom];
	btn.frame = frame;
	[btn setImage:image forState:UIControlStateNormal];
	[btn setImage:image forState:UIControlStateHighlighted];
	return btn;
}


@end
