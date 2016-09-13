//
//  UIView+Initializers.m
//  Created by Devin Ross on 4/17/15.
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

#import "UIView+Initializers.h"
#import "UIView+TKCategory.h"

@implementation UIView (Initializers)

+ (instancetype) viewWithFrame:(CGRect)frame{
    return [[[self class] alloc] initWithFrame:frame];
}

+ (instancetype) viewWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor{
    return [[[self class] alloc] initWithFrame:frame backgroundColor:backgroundColor];
}

- (instancetype) initWithFrame:(CGRect)frame backgroundColor:(UIColor*)backgroundColor{
    self = [self initWithFrame:frame];
    self.backgroundColor = backgroundColor;
    return self;
}

+ (instancetype) viewWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor cornerRadius:(CGFloat)cornerRadius{
    return [[[self class] alloc] initWithFrame:frame backgroundColor:backgroundColor cornerRadius:cornerRadius];
}

- (instancetype) initWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor cornerRadius:(CGFloat)cornerRadius{
    self = [self initWithFrame:frame];
    self.backgroundColor = backgroundColor;
    self.cornerRadius = cornerRadius;
    return self;
}

+ (instancetype) viewWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor cornerRadius:(CGFloat)cornerRadius borderColor:(nonnull UIColor*)borderColor borderWidth:(CGFloat)borderWidth{
    return [[[self class] alloc] initWithFrame:frame backgroundColor:backgroundColor cornerRadius:cornerRadius borderColor:borderColor borderWidth:borderWidth];
}

- (instancetype) initWithFrame:(CGRect)frame backgroundColor:(nonnull UIColor*)backgroundColor cornerRadius:(CGFloat)cornerRadius borderColor:(nonnull UIColor*)borderColor borderWidth:(CGFloat)borderWidth{
    self = [self initWithFrame:frame];
    self.backgroundColor = backgroundColor;
    self.cornerRadius = cornerRadius;
    [self setBorderWithColor:borderColor width:borderWidth];
    return self;
}


@end
