//
//  NSString+TKUIKit.m
//  Created by Devin Ross on 10/13/16.
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

#import "NSString+TKUIKit.h"

@implementation NSString (TKUIKit)


- (CGFloat) heightForWidth:(CGFloat)widthValue andFont:(UIFont *)font{
	CGFloat result = font.pointSize + 4;
	CGSize textSize = { widthValue, CGFLOAT_MAX };       //Width and height of text area
	NSDictionary *atr = @{ NSFontAttributeName:font };
	CGRect frame = [self boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:atr context:nil];
	CGSize size = CGSizeMake(frame.size.width, frame.size.height+1);
	return MAX(size.height, result); //At least one row
}


@end
