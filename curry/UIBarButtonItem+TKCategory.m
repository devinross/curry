//
//  UIBarButtonItem+TKCategory.m
//  Created by Devin Ross on 3/23/11.
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

#import "UIBarButtonItem+TKCategory.h"
#import "UIButton+TKCategory.h"

@implementation UIBarButtonItem (TKCategory)


+ (UIBarButtonItem*) barButtonItemWithImage:(UIImage*)img highlightedImage:(UIImage*)highlighedImage target:(id)t selector:(SEL)s{
	
	CGRect r = CGRectZero;
	r.size = img.size;
	
	UIButton *btn = [UIButton buttonWithFrame:r image:img highlightedImage:highlighedImage];
	
	[btn addTarget:t action:s forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
	item.target = t;
	item.action = s;
	return item;
	
}



+ (UIBarButtonItem*) doneItemWithTarget:(id)target action:(SEL)action{
	return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:target action:action];
}

+ (UIBarButtonItem*) cancelItemWithTarget:(id)target action:(SEL)action{
	return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:target action:action];
}
+ (UIBarButtonItem*) saveItemWithTarget:(id)target action:(SEL)action{
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:target action:action];
	item.style = UIBarButtonItemStyleDone;
	return item;
}

+ (UIBarButtonItem*) actionItemWithTarget:(id)target action:(SEL)action{
	return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:target action:action];
}

+ (UIBarButtonItem*) activityItemWithIndicatorStyle:(UIActivityIndicatorViewStyle)style{
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
	[indicator startAnimating];
	return [[UIBarButtonItem alloc] initWithCustomView:indicator];
}


+ (UIBarButtonItem*) activityItem{
	return [UIBarButtonItem activityItemWithIndicatorStyle:UIActivityIndicatorViewStyleWhite];
}

+ (UIBarButtonItem*) fixedSpaceItemWithWidth:(CGFloat)width{
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	item.width = width;
	return item;
}
+ (UIBarButtonItem*) flexibleSpaceItem{
	return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}


@end
