//
//  NSTimer+Blocks.m
//  Created by Devin Ross on 5/22/15.
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

#import "NSTimer+Blocks.h"

@implementation NSTimer (Blocks)

+ (NSTimer *) tk_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(void))block{
	return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(runBlockHandler:) userInfo:block repeats:repeats];
}

+ (NSTimer *) tk_timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(void))block{
	return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(runBlockHandler:) userInfo:block repeats:repeats];
}

- (instancetype) tk_initWithFireDate:(NSDate *)date interval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(void))block{
	return [self initWithFireDate:date interval:seconds target:self.class selector:@selector(runBlockHandler:) userInfo:block repeats:repeats];
}

+ (void) runBlockHandler:(NSTimer *)timer{
	if ([timer.userInfo isKindOfClass:NSClassFromString(@"NSBlock")]){
		void (^block)(void) = timer.userInfo;
		block();
	}
}

@end
