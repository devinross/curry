//
//  UIImageView+TKCategory.m
//  Created by Devin Ross on 12/12/10.
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

#import "UIImageView+TKCategory.h"


@implementation UIImageView (TKCategory)

+ (instancetype) imageViewWithImageNamed:(NSString*)imageName{
	return [[[self class] alloc] initWithImage:[UIImage imageNamed:imageName]];
}

+ (instancetype) imageViewWithImageNamed:(NSString*)imageName renderMode:(UIImageRenderingMode)mode{
	UIImage *img = [[UIImage imageNamed:imageName] imageWithRenderingMode:mode];
	return [[[self class] alloc] initWithImage:img];
}

+ (instancetype) imageViewWithFrame:(CGRect)frame{
	return [[[self class] alloc] initWithFrame:frame];
}



- (void) setAnimationImageNames:(NSArray <NSString*>*)names{
	NSMutableArray *images = [NSMutableArray arrayWithCapacity:names.count];
	for(NSString *name in names){
		[images addObject:[UIImage imageNamed:name]];
	}
	self.animationImages = images;
}

@end
