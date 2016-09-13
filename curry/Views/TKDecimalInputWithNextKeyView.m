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
#import "TKFoundation.h"
#import "TKInputKey.h"
#import "UIImage+TKCategory.h"
#import "TKUIKit.h"



@implementation TKDecimalInputWithNextKeyView

- (instancetype) initWithFrame:(CGRect)frame withKeysModels:(NSArray *)keys{
	
	UIImage *next = [UIImage imageNamed:@"keyboard-next-key" inBundle:[NSBundle bundleForClass:[TKInputView class]] compatibleWithTraitCollection:[UITraitCollection traitCollectionWithDisplayScale:[UIScreen mainScreen].scale]];
	
	self.nextKey = [[TKInputKey alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.25, frame.size.height) symbol:next normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:NO];
	self.nextKey.accessibilityLabel = NSLocalizedString(@"Next", @"");

	NSMutableArray *array = [NSMutableArray arrayWithArray:keys];
	[array addObjectsFromArray:@[self.nextKey,self.backspaceKey]];
	
	if(!(self=[super initWithFrame:frame withKeysModels:array])) return nil;
	return self;
}


- (void) layoutSubviews{
	[super layoutSubviews];
	
	CGRect backRect = self.backspaceKey.frame;
	if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
		self.nextKey.frame = CGRectMake(backRect.origin.x, 0, backRect.size.width, CGFrameGetMaxY(self.sixKey));
		self.backspaceKey.frame = CGRectMake(backRect.origin.x, CGFrameGetMaxY(self.sixKey), backRect.size.width, CGFrameGetMaxY(self.zeroKey) - CGFrameGetMaxY(self.sixKey));
	}else{
		CGFloat keyHeight = CGFrameGetMaxY(self.sixKey) - CGFrameGetMinY(self.oneKey);
		self.nextKey.frame = CGRectMake(backRect.origin.x, CGFrameGetMinY(self.oneKey), backRect.size.width, keyHeight);
		self.backspaceKey.frame = CGRectMake(backRect.origin.x, CGFrameGetMinY(self.eightKey), backRect.size.width, keyHeight );
	}
	
}

@end
