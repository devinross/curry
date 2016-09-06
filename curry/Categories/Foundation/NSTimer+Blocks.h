//
//  NSTimer+Blocks.h
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

@import Foundation;

/** Additional functionality for `NSTimer` with block functionality. */
@interface NSTimer (Blocks)

/** Additional functionality for `NSTimer` with block functionality.
 @param seconds The time until the timer fire.
 @param repeats A flag for having the timer repeat.
 @param block The block that will be called by the timer.
 @return The `NSTimer` object.
 */
+ (NSTimer *) tk_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(void))block;

/** Additional functionality for `NSTimer` with block functionality.
 @param seconds The time until the timer fire.
 @param repeats A flag for having the timer repeat.
 @param block The block that will be called by the timer.
 @return The `NSTimer` object.
 */
+ (NSTimer *) tk_timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(void))block;

/** Additional functionality for `NSTimer` with block functionality.
 @param date The date the timer will first fire.
 @param seconds The time until the timer fire.
 @param repeats A flag for having the timer repeat.
 @param block The block that will be called by the timer.
 @return The `NSTimer` object.
 */
- (instancetype) tk_initWithFireDate:(NSDate *)date interval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(void))block;

@end
