//
//  TKDecimalInputView.m
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


#import "TKDecimalInputView.h"
#import "TKInputKey.h"
#import "TKFoundation.h"
#import "TKUIKit.h"

@implementation TKDecimalInputView


- (instancetype) initWithFrame:(CGRect)frame withKeysModels:(NSArray<TKInputKey*>*)keys{
	frame.size = [TKInputView sizeOfKeyboardForMainScreen];
	
	self.padRect = CGRectMake(0, 0, 0.75, 1);
	
	CGFloat w = self.padRect.size.width * frame.size.width;
	CGFloat h = self.padRect.size.height * frame.size.height;
	
	CGSize s = CGSizeMake(w, h);
	self.decimalKey = [TKInputKey keyWithFrame:CGRectMakeWithSize( 0, 0, s) symbol:@"." normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeDark runner:YES];

	NSMutableArray *ar = [NSMutableArray arrayWithObject:self.decimalKey];
	[ar addObjectsFromArray:keys];
	
	if(!(self=[super initWithFrame:frame withKeysModels:ar])) return nil;
	
	return self;
}


- (void) layoutSubviews{
	[super layoutSubviews];
	
	CGRect zeroRect = self.zeroKey.frame;
	zeroRect.size.width = CGFrameGetMaxX(self.twoKey) - CGRectGetMinX(zeroRect);
	self.zeroKey.frame = zeroRect;
	
	CGRect decRect = self.zeroKey.frame;
	decRect.origin.x = CGFrameGetMinX(self.threeKey);
	decRect.size.width = CGFrameGetWidth(self.twoKey);
	self.decimalKey.frame = decRect;
}






- (NSArray*) keypadKeys{
	NSMutableArray *array = [super keypadKeys].mutableCopy;
	[array addObject:self.decimalKey];
	return array.copy;
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
