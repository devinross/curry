//
//  UIAlertView+Blocks.m
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

#import "UIAlertView+Blocks.h"

static const void *UIAlertViewActionsKey = &UIAlertViewActionsKey;
#import <objc/runtime.h>

@interface UIAlertView (BlocksPrivate)

@property (nonatomic,strong) NSMutableArray *actions;
@end

@implementation UIAlertView (BlocksPrivate)

- (void) setActions:(NSMutableArray *)actions{
    objc_setAssociatedObject(self, UIAlertViewActionsKey, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray*) actions{
    return objc_getAssociatedObject(self, UIAlertViewActionsKey);
}

@end

@implementation UIAlertView (Blocks)

typedef void (^UIAlertViewBlock)(UIAlertView *sender);

+ (UIAlertView*) alertWithTitle:(NSString*)title message:(NSString*)message{
    return [[UIAlertView alloc] initWithTitle:title messsge:message];
}

- (instancetype) initWithTitle:(NSString *)title messsge:(NSString*)message{
    return [self initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
}

- (void) addButtonWithTitle:(NSString*)title handler:(void (^)(UIAlertView *sender))block{
    
    if(!self.actions){
        NSMutableArray *actions = [NSMutableArray array];
        for(NSInteger i=0;i<self.numberOfButtons;i++){
            [actions addObject:[NSNull null]];
        }
        self.actions = actions;
    }
    self.delegate = self;
    [self addButtonWithTitle:title];
    [self.actions addObject:( (id)block ?: [NSNull null])];
    
}

- (void) addCancelButtonWithTitle:(NSString*)title handler:(void (^)(UIAlertView *sender))block{
    [self addButtonWithTitle:title handler:block];
    self.cancelButtonIndex = self.numberOfButtons - 1;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    id block = self.actions[buttonIndex];
    if(block == [NSNull null]) return;
    UIAlertViewBlock handler = block;
    handler(self);
}



@end