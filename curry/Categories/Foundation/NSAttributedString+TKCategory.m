//
//  NSAttributedString+TKCategory.m
//  Created by Devin Ross on 12/16/14.
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

#import "NSAttributedString+TKCategory.h"

@implementation NSAttributedString (TKCategory)


+ (instancetype) attributedStringWithFormat:(NSString*)format, ...{
	va_list args;
	va_start(args, format);
	NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
	
	NSAttributedString *atr = [[[self class] alloc] initWithString:str];
	va_end(args);
	return atr;
}

+ (NSAttributedString*) attributedStringWithText:(NSString*)text lineHeight:(CGFloat)space{
	if(text.length < 1) return nil;
	NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
	[paragrahStyle setLineSpacing:space];
	NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
	[attr addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0,attr.length)];
	return attr;
}

+ (NSAttributedString*) attributedStringWithText:(NSString *)text kerning:(CGFloat)kerning{
	if(text.length < 1) return nil;
	NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
	[attr addAttribute:NSKernAttributeName value:@(kerning) range:NSMakeRange(0, text.length)];
	return attr;
}


+ (NSAttributedString*) attributedStringWithText:(NSString *)text lineHeight:(CGFloat)space kerning:(CGFloat)kerning{
	if(text.length < 1) return nil;
	NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
	[paragrahStyle setLineSpacing:space];
	NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
	[attr addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0,attr.length)];
	[attr addAttribute:NSKernAttributeName value:@(kerning) range:NSMakeRange(0, text.length)];
	return attr;
}


@end
