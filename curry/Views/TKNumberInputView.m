//
//  TKNumberInputView.m
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


#import "TKNumberInputView.h"
#import "UIDevice+TKCategory.h"
#import "TKInputKey.h"
#import "UIImage+TKCategory.h"
#import "TKFoundation.h"
#import "TKUIKit.h"

@implementation TKNumberInputView

- (instancetype) initWithFrame:(CGRect)frame{
	self = [self initWithFrame:frame withKeysModels:@[]];
	return self;
}


- (instancetype) initWithFrame:(CGRect)frame withKeysModels:(NSArray*)keys{
	frame.size = [TKInputView sizeOfKeyboardForMainScreen];
	
	self.padRect = CGRectMake(0, 0, 0.75, 1);
	
	CGFloat w = self.padRect.size.width * frame.size.width;
	CGFloat h = self.padRect.size.height * frame.size.height;
	
	CGSize s = CGSizeMake(w, h);
	self.oneKey =		[TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"1" normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];
	self.twoKey =		[TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"2" normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];
	self.threeKey =		[TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"3" normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];
	self.fourKey =		[TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"4" normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];
	self.fiveKey =		[TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"5" normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];
	self.sixKey =		[TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"6" normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];
	self.sevenKey =		[TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"7" normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];
	self.eightKey =		[TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"8" normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];
	self.nineKey =		[TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"9" normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];
	self.zeroKey =		[TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"0" normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];
	
	NSMutableArray *ar = [NSMutableArray arrayWithArray:self.keypadKeys];
	[ar addObjectsFromArray:keys];
	[ar addObject:self.backspaceKey];
	if(!(self=[super initWithFrame:frame withKeysModels:ar])) return nil;
	return self;
}



- (void) layoutSubviews{
	[super layoutSubviews];
	
	CGRect padPer = self.padRect;
	CGSize cntSize = self.containerView.frame.size;
	CGRect padRect = CGRectMake(round(padPer.origin.x * cntSize.width), round(padPer.origin.y * cntSize.height), round(padPer.size.width * cntSize.width), round(padPer.size.height * cntSize.height));
	NSInteger w = padRect.size.width / 3;
	NSInteger h = padRect.size.height / 4;
	NSInteger xPad = 0, leftInset = 0, vertInset = 0, vertSpace = 0, bottomPad = 2;
	
	
	if([UIDevice currentDevice].padIdiom){
		xPad = 16, leftInset = 24, vertInset = 12, vertSpace = 10;
		w = (padRect.size.width - leftInset - leftInset - (xPad * 2)) / 3;
		h = (padRect.size.height - vertInset - vertInset - (vertSpace * 3)) / 4;
		bottomPad = 0;
	}
	
	CGSize s = CGSizeMake(w, h);
	self.oneKey.frame =		CGRectMakeWithSize( leftInset,				vertInset,		s);
	self.twoKey.frame =		CGRectMakeWithSize( leftInset+w+xPad,		vertInset,		s);
	self.threeKey.frame =	CGRectMakeWithSize( leftInset+w*2+xPad*2,	vertInset,		s);
	self.fourKey.frame =	CGRectMakeWithSize( leftInset,				h+vertSpace + vertInset,	s);
	self.fiveKey.frame =	CGRectMakeWithSize( leftInset+w+xPad,		h+vertSpace + vertInset,	s);
	self.sixKey.frame =		CGRectMakeWithSize( leftInset+w*2+xPad*2,	h+vertSpace + vertInset,	s);
	self.sevenKey.frame =	CGRectMakeWithSize( leftInset,				(h+vertSpace)*2 + vertInset,	s);
	self.eightKey.frame =	CGRectMakeWithSize( leftInset+w+xPad,		(h+vertSpace)*2 + vertInset,	s);
	self.nineKey.frame =	CGRectMakeWithSize( leftInset+w*2+xPad*2,	(h+vertSpace)*2 + vertInset,	s);
	self.zeroKey.frame =	CGRectMake( leftInset, h*3+vertSpace*3 + vertInset,	w*3+xPad*2, s.height);
	
	
	NSInteger minX = CGRectGetMaxX(self.threeKey.frame) + xPad;
	
	if([UIDevice currentDevice].phoneIdiom){
		self.backspaceKey.frame = CGRectMake(minX, vertInset, self.containerView.frame.size.width - minX + 1, padRect.size.height + bottomPad);
	}else{
		self.backspaceKey.frame = CGRectMake(minX, vertInset, s.width, h);
	}
	
}

- (NSArray*) keypadKeys{
	return @[self.oneKey,self.twoKey,self.threeKey,self.fourKey,self.fiveKey,self.sixKey,self.sevenKey,self.eightKey,self.nineKey,self.zeroKey];
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	
	if(self.selectedKey && [self.keypadKeys containsObject:self.selectedKey]){
		
		BOOL insert = YES;
		
		if(self.textField.delegate && [self.textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
			insert = [self.textField.delegate textField:self.textField shouldChangeCharactersInRange:NSMakeRange(self.textField.text.length, 0) replacementString:self.selectedKey.label.text];
		
		if(insert)
			[self.textField insertText:self.selectedKey.label.text];
		
		[super touchesCancelled:touches withEvent:event];
		return;
	}
	
	[super touchesEnded:touches withEvent:event];
	
}


@end
