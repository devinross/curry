//
//  UIScreen+TKCategory.m
//  Created by Devin Ross on 8/31/13.
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

#import "UIScreen+TKCategory.h"
#import "NSTimer+Blocks.h"
@implementation UIScreen (TKCategory)

- (CGFloat) onePixelSize{
	return 1.0f / self.scale;
}



#if !TARGET_OS_TV
- (void) setBrightness:(CGFloat)brightness animated:(BOOL)animated{
	if(brightness==self.brightness) return;
	
	if(!animated){
		self.brightness = brightness;
		return;
	}
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(adjustBrightness:) object:nil];
	[self performSelector:@selector(adjustBrightness:) withObject:@(brightness) afterDelay:.01];
}

- (void) adjustBrightness:(NSNumber*)sender {
	CGFloat brightness = self.brightness;
	CGFloat goalBrightness = sender.doubleValue;
	if(fabs(brightness-goalBrightness)<0.01) return;
	BOOL goUp = goalBrightness > brightness;
	self.brightness += goUp ? 0.01 : -0.01;
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(adjustBrightness:) object:nil];
	[self performSelector:@selector(adjustBrightness:) withObject:sender afterDelay:.01];
}

#endif

@end
