//
//  UIGestureRecognizer+Blocks.m
//  Created by Devin Ross on 4/16/15.
//

#import "UIGestureRecognizer+Blocks.h"
#import <objc/runtime.h>


static const void *UIGestureRecognizerHandlerBlockKey = &UIGestureRecognizerHandlerBlockKey;


@implementation UIGestureRecognizer (Blocks)

+ (instancetype) recognizerWithHandler:(void (^)(UIGestureRecognizer *sender))block{
    return [[[self class] alloc] initWithHandler:block];
}

- (instancetype) initWithHandler:(void (^)(UIGestureRecognizer *sender))block{
    if(!(self=[self initWithTarget:self action:@selector(handleAction:)])) return nil;
    self.handler = block;
    return self;
}


- (void) handleAction:(UIGestureRecognizer *)recognizer{
    void (^handler)(UIGestureRecognizer *sender) = recognizer.handler;
    if (!handler) return;
    
    void (^block)(void) = ^{
        handler(self);
    };
    
    block();
    return;

}

- (void) setHandler:(void (^)(UIGestureRecognizer *sender))handler{
    objc_setAssociatedObject(self, UIGestureRecognizerHandlerBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIGestureRecognizer *sender)) handler{
    return objc_getAssociatedObject(self, UIGestureRecognizerHandlerBlockKey);
}


@end