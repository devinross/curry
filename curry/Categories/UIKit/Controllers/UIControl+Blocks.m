//
//  UIControl+Blocks.m
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

#import "UIControl+Blocks.h"
#import <objc/runtime.h>

static const void *UIControlHandlersKey = &UIControlHandlersKey;

#pragma mark Private

@interface TKControlWrapper : NSObject <NSCopying>

- (id) initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

@property (nonatomic) UIControlEvents controlEvents;
@property (nonatomic, copy) void (^handler)(id sender);

@end

@implementation TKControlWrapper

- (instancetype) initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents{
    if(!(self=[super init])) return nil;
    
    self.handler = handler;
    self.controlEvents = controlEvents;
    
    return self;
}

- (id) copyWithZone:(NSZone *)zone{
    return [[TKControlWrapper alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void) invoke:(id)sender{
    self.handler(sender);
}

@end

@implementation UIControl (Blocks)

- (void) addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents{
    NSParameterAssert(handler);
    
    NSMutableDictionary *events = objc_getAssociatedObject(self, UIControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, UIControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSMutableSet *handlers = events[key];
    if (!handlers) {
        handlers = [NSMutableSet set];
        events[key] = handlers;
    }
    
    TKControlWrapper *target = [[TKControlWrapper alloc] initWithHandler:handler forControlEvents:controlEvents];
    [handlers addObject:target];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    
}

- (void) removeEventHandlersForControlEvents:(UIControlEvents)controlEvents{
    
    NSMutableDictionary *events = objc_getAssociatedObject(self, UIControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, UIControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    if (!handlers) return;
    
    [handlers enumerateObjectsUsingBlock:^(id sender, BOOL *stop) {
        [self removeTarget:sender action:NULL forControlEvents:controlEvents];
    }];
    [events removeObjectForKey:key];
    
}

- (BOOL) hasEventHandlersForControlEvents:(UIControlEvents)controlEvents{
    
    NSMutableDictionary *events = objc_getAssociatedObject(self, UIControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, UIControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    if (!handlers) return NO;
    
    return !!handlers.count;
}

@end
