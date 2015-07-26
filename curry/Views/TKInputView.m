//
//  TKInputView.m
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


#import "TKInputView.h"
#import "UIDevice+TKCategory.h"
#import "UIColor+TKCategory.h"
#import "TKInputKey.h"
#import "UIView+TKCategory.h"
#import "UIImageView+TKCategory.h"
#import "UIImage+TKCategory.h"
#import "TKFoundation.h"

@interface TKInputView ()

@property (nonatomic,strong) NSArray *keyViews;
@property (nonatomic,assign) TKInputKey *originalSelectedKey;
@property (nonatomic,strong) TKInputKey *selectedKey;
@property (nonatomic,strong) NSTimer *holdTimer;
@property (nonatomic,assign) NSInteger holdCounter;

@end

@implementation TKInputView



+ (CGSize) sizeOfKeyboardForMainScreen{
	CGFloat height = 352;
	if([UIDevice currentDevice].phoneIdiom){
		height = [UIScreen mainScreen].traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 162 :  216;
	}
	return CGSizeMake([UIScreen mainScreen].bounds.size.width, height);
}

- (instancetype) initWithFrame:(CGRect)frame withKeysModels:(NSArray*)keys{
	frame.size = [TKInputView sizeOfKeyboardForMainScreen];
	if(!(self=[super initWithFrame:frame])) return nil;
	
	self.keyViews = keys;
	self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.backgroundColor = [UIColor colorWithHex:0xd7dadf];
	self.clipsToBounds = YES;
	self.multipleTouchEnabled = NO;
	self.exclusiveTouch = YES;
	
	CGRect cntFrame = frame;
	if([UIDevice currentDevice].padIdiom){
		cntFrame.size.width = 544;
		cntFrame.origin.x = round((self.frame.size.width - cntFrame.size.width) / 2);
	}else{
		cntFrame.origin = CGPointMake(0, 1);
		cntFrame.size.height -= 1;
	}
	
	
	
	self.containerView = [[UIView alloc] initWithFrame:cntFrame];
	self.containerView.clipsToBounds = YES;
	
	if([UIDevice currentDevice].padIdiom)
		self.containerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
	else
		self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.containerView.clipsToBounds = YES;
	[self addSubview:self.containerView];
	
	
	NSInteger tag = 0;
	
	for(TKInputKey *key in keys){
		key.tag = tag;
		[key setHighlighted:NO];
		[self.containerView addSubviewToBack:key];
		tag++;
	}
	
	
	
	
	if([UIDevice currentDevice].padIdiom){
		
		

        CGRect rect = CGRectMake(frame.size.width - 80 - 32, frame.size.height - 75 - 12, 80, 75);
		
		UIImage *img = [UIImage imageNamed:@"keyboard-down-keyboard" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:[UITraitCollection traitCollectionWithDisplayScale:[UIScreen mainScreen].scale]];

		self.hideKeyboardKey = [[TKInputKey alloc] initWithFrame:rect symbol:img normalType:TKInputKeyTypeDefault selectedType:TKInputKeyTypeHighlighted runner:NO];
		self.hideKeyboardKey.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
		self.hideKeyboardKey.tag = tag;
		[self.hideKeyboardKey setHighlighted:NO];
		[self addSubview:self.hideKeyboardKey];
		
		UIImage *dotsImage = [UIImage imageNamed:@"keyboard-move-keyboard-dots" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:[UITraitCollection traitCollectionWithDisplayScale:[UIScreen mainScreen].scale]];
		UIImageView *dots = [UIImageView imageViewWithFrame:CGRectMakeWithSize(CGRectGetWidth(frame) - 18, CGRectGetHeight(frame) - 57, dotsImage.size)];
		dots.image = dotsImage;
		dots.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
		[self addSubview:dots];
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHideNotification:) name:UIKeyboardDidHideNotification object:nil];
	
    return self;
}

- (void) dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void) didHideNotification:(id)sender{

	if(self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPhone){
		CGFloat height = self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 162 :  216;
		CGRect rect = self.frame;
		rect.size.height = height;
		self.frame = rect;
	}
	
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	
	UITouch *touch = [touches anyObject];
	UIView *view = [self hitTest:[touch locationInView:self] withEvent:event];
	
	if(self.selectedKey!=nil){
		[self.selectedKey setHighlighted:NO];
		self.originalSelectedKey = nil;
		self.selectedKey = nil;
	}
	
	if(![view isKindOfClass:[TKInputKey class]]) return;
	[[UIDevice currentDevice] playInputClick];
	
	self.originalSelectedKey = (TKInputKey*)view;
	self.selectedKey = self.originalSelectedKey;
	[self.selectedKey setHighlighted:YES];
	[self.containerView bringSubviewToFront:self.selectedKey];
    
    if(self.originalSelectedKey.canTapAndHold){
        self.holdCounter = 0;
        [self.holdTimer invalidate];
        self.holdTimer = nil;
        self.holdTimer = [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(holding:) userInfo:nil repeats:YES];
    }
	
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
	UITouch *touch = [touches anyObject];
	UIView *view = [self hitTest:[touch locationInView:self] withEvent:event];
    
	TKInputKey *currentKey = nil;
	if([view isKindOfClass:[TKInputKey class]])
		currentKey = (TKInputKey*)view;
	
	BOOL on = NO;
	if(self.originalSelectedKey == currentKey)
		on = YES;
	else if(self.originalSelectedKey.runner && currentKey.runner)
		on = YES;
	
	
	if(self.selectedKey != currentKey){
		[self.selectedKey setHighlighted:NO];
		self.selectedKey = nil;
	}
	
	if(on){
		self.selectedKey = currentKey;
		[self.containerView bringSubviewToFront:self.selectedKey];
		[self.selectedKey setHighlighted:YES];
	}
	
}

- (void) holding:(id)sender{
    
    if(self.originalSelectedKey == self.selectedKey){
        self.holdCounter++;
        if(self.holdCounter < 6){
            [self sendTapKeyEvent];
        }else{
            [self sendTapKeyEvent];
            [self sendTapKeyEvent];
            [self sendTapKeyEvent];
            [self sendTapKeyEvent];
            [self sendTapKeyEvent];
        }
    }
    
}

- (void) sendTapKeyEvent{
    
    if(self.selectedKey == self.backspaceKey){
        
        BOOL delete = YES;
        if(self.textField.text.length < 1)
            delete = NO;
        else if(self.textField.delegate && [self.textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
            delete = [self.textField.delegate textField:self.textField shouldChangeCharactersInRange:NSMakeRange(self.textField.text.length-1, 1) replacementString:@""];
        
        if(delete) [self.textField deleteBackward];
        
    }else if(self.selectedKey){
        [self.delegate inputView:self didSelectKey:self.selectedKey];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	
    if(self.holdTimer == nil || self.holdCounter < 1)
        [self sendTapKeyEvent];

	[self touchesCancelled:touches withEvent:event];
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	
	[self.selectedKey setHighlighted:NO];
	self.selectedKey = nil;
	self.originalSelectedKey = nil;
    [self.holdTimer invalidate];
    self.holdTimer = nil;
    self.holdCounter = 0;
	
}
- (BOOL) enableInputClicksWhenVisible{
    return YES;
}

@end