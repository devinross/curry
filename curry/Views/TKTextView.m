//
//  TKTextView.m
//  Created by Devin Ross on 5/18/13.
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

#import "TKTextView.h"

@implementation TKTextView


#pragma mark Init & Friends
- (instancetype) initWithFrame:(CGRect)frame{
	if(!(self=[super initWithFrame:frame])) return nil;
	[self _setupView];
	return self;
}
- (instancetype) initWithCoder:(NSCoder *)aDecoder{
	if(!(self=[super initWithCoder:aDecoder])) return nil;
	[self _setupView];
	return self;
}
- (void) awakeFromNib{
	[super awakeFromNib];
	[self _setupView];
}
- (void) _setupView{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}
- (void) dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) drawRect:(CGRect)rect{
	[super drawRect:rect];
	
	if(_placeholderLabel){
		if(self.placeholderLabel.superview==nil){
			[self addSubview:self.placeholderLabel];
			[self sendSubviewToBack:self.placeholderLabel];
		}
		
		if([self respondsToSelector:@selector(textContainer)])
			self.placeholderLabel.frame = CGRectMake(self.textContainerInset.left + 5, self.textContainerInset.top, CGRectGetWidth(self.bounds) - 8, 0);
		else
			self.placeholderLabel.frame = CGRectMake(8,8,CGRectGetWidth(self.bounds) - 16,0);
		
		[self.placeholderLabel sizeToFit];
		
	}
	_placeholderLabel.alpha = self.text.length < 1 ? 1 : 0;
}


- (void) _textChanged:(NSNotification *)notification{
	if(self.placeholder.length == 0) return;
	BOOL showPlaceholder = self.text.length < 1;
	_placeholderLabel.alpha = showPlaceholder ? 1 : 0;

	if(showPlaceholder) {
		self.accessibilityLabel = _placeholderLabel.text;
	}else{
		self.accessibilityLabel = self.text;
	}
}


#pragma mark Properties
- (void) setFont:(UIFont *)font{
	[super setFont:font];
	self.placeholderLabel.font = font;
	[self setNeedsDisplay];
}
- (void) setText:(NSString *)text{
	[super setText:text];
	[self _textChanged:nil];
}
- (void) setTextContainerInset:(UIEdgeInsets)textContainerInset{
	[super setTextContainerInset:textContainerInset];
	[self setNeedsDisplay];
}
- (void) setPlaceholder:(NSString *)placeholder{
	
	if(placeholder.length < 1){
		self.placeholderLabel.text = placeholder;
		[self setNeedsDisplay];
		return;
	}
	
	self.placeholderLabel.text = placeholder;
	
	[self setNeedsDisplay];
}
- (NSString*) placeholder{
	return _placeholderLabel.text;
}
- (void) setPlaceholderColor:(UIColor *)placeholderColor{
	self.placeholderLabel.textColor = placeholderColor;
	[self setNeedsDisplay];
}
- (UIColor*) placeholderColor{
	return _placeholderLabel.textColor;
}
- (UILabel*) placeholderLabel{
	if(_placeholderLabel) return _placeholderLabel;
	
	_placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,CGRectGetWidth(self.bounds) - 16,0)];
	_placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
	_placeholderLabel.numberOfLines = 0;
	_placeholderLabel.font = [UIFont systemFontOfSize:11];
	_placeholderLabel.backgroundColor = [UIColor clearColor];
	_placeholderLabel.textColor = [UIColor lightGrayColor];
	_placeholderLabel.isAccessibilityElement = NO;
	
	if([self respondsToSelector:@selector(textContainer)]){
		_placeholderLabel.textColor = [UIColor colorWithWhite:0.80 alpha:1];
		_placeholderLabel.frame = CGRectMake(2, 8, CGRectGetWidth(self.bounds) - 8, 0);
	}
	_placeholderLabel.alpha = 0;
	return _placeholderLabel;
}

@end
