//
//  UIGestureRecognizer+Blocks.m
//  Created by Devin Ross on 4/16/15.
//

#import "UIGestureRecognizer+Blocks.h"
#import <objc/runtime.h>


static const void *UIGestureRecognizerHandlerBlockKey = &UIGestureRecognizerHandlerBlockKey;

@interface UIGestureRecognizer (BlocksKitInternal)

- (void) handleAction:(UIGestureRecognizer *)recognizer;

@end

@implementation UIGestureRecognizer (Blocks)

+ (instancetype) recognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block{
    return [[[self class] alloc] initWithHandler:block];
}

- (instancetype) initWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block{
    if(!(self=[self initWithTarget:self action:@selector(handleAction:)])) return nil;
    self.handler = block;
    return self;
}




- (void) handleAction:(UIGestureRecognizer *)recognizer{
    void (^handler)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) = recognizer.handler;
    if (!handler) return;
    
    CGPoint location = [self locationInView:self.view];
    void (^block)(void) = ^{
        handler(self, self.state, location);
    };
    
    block();
    return;

}

- (void) setHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))handler{
    objc_setAssociatedObject(self, UIGestureRecognizerHandlerBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location)) handler{
    return objc_getAssociatedObject(self, UIGestureRecognizerHandlerBlockKey);
}


@end