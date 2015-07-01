//
//  UIControl+Blocks.h
//  Created by Devin Ross on 5/1/15.
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

@import UIKit;

/** Introduces block callbacks to `UIControl`. */
@interface UIControl (Blocks)

/** Add a callback block to a control event.
 @param handler  The block that is called when an event occurs.
 @param controlEvents The events that would trigger a block.
 */
- (void) addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

/* Remove the blocks for a specific event.
 @param controlEvents The events that would trigger a block.
 */
- (void) removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

/* A way to check if there is a callback for a specific block.
 @param controlEvents The events that would trigger a block.
 @return Returns YES if the event has a block. NO is it does not.
 */
- (BOOL) hasEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end
