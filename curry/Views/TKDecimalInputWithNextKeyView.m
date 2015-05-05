//
//  TKDecimalInputWithNextKeyView.m
//  Created by Devin Ross on 3/21/14.
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


#import "TKDecimalInputWithNextKeyView.h"
#import "UIDevice+TKCategory.h"
#import "TKFoundation.h"
#import "TKInputKey.h"
#import "UIImage+TKCategory.h"

@implementation TKDecimalInputWithNextKeyView

- (instancetype) initWithFrame:(CGRect)frame{
	frame.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIDevice currentDevice].phoneIdiom ? 216 : 352);
	
	CGFloat yPad = 0, xPad = 0, xMargin = 0;
	CGFloat w = frame.size.width / 4;
	CGFloat h = frame.size.height / 4;
	
	if([UIDevice currentDevice].padIdiom){
		w = 108, h = 75, yPad = 10, xPad = 16, xMargin = 28;
	}
    
    UIImage *back = [UIImage imageNamed:@"keyboard-backspace-key" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:[UITraitCollection traitCollectionWithDisplayScale:[UIScreen mainScreen].scale]];
    UIImage *next = [UIImage imageNamed:@"keyboard-next-key" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:[UITraitCollection traitCollectionWithDisplayScale:[UIScreen mainScreen].scale]];

	self.nextKey = [[TKInputKey alloc] initWithFrame:CGRectMake(xMargin+w*3 + (xPad*3), yPad, w+1, h*2+yPad) symbol:next normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:NO];
	self.backspaceKey = [[TKInputKey alloc] initWithFrame:CGRectMake(xMargin+w*3+ (xPad*3), h*2+yPad*3, w+1, h*2+yPad) symbol:back normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:NO];
	
	CGRect pad = CGRectMake(0, 0, w*3, h*4);
	
	if(!(self=[super initWithFrame:frame withKeysModels:@[self.nextKey,self.backspaceKey] keypadFrame:pad])) return nil;
    return self;
}

@end
