//
//  UIActionSheet+Blocks.m
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

#import "UIActionSheet+Blocks.h"
#import <objc/runtime.h>

static const void *UIActionSheetActionsKey = &UIActionSheetActionsKey;


@interface UIActionSheet (BlocksPrivate)

@property (nonatomic,strong) NSMutableArray *actions;
@end

@implementation UIActionSheet (BlocksPrivate)


- (void) setActions:(NSMutableArray *)actions{
    objc_setAssociatedObject(self, UIActionSheetActionsKey, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray*) actions{
    return objc_getAssociatedObject(self, UIActionSheetActionsKey);
}

@end

@implementation UIActionSheet (Blocks)

typedef void (^UIActionSheetBlock)(UIActionSheet *sender);

+ (UIActionSheet*) sheetWithTitle:(NSString*)title{
    return [[UIActionSheet alloc] initWithTitle:title];
}

- (instancetype) initWithTitle:(NSString *)title{
    return [self initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
}

- (void) addButtonWithTitle:(NSString*)title handler:(void (^)(UIActionSheet *sender))block{
    
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

- (void) addCancelButtonWithTitle:(NSString*)title handler:(void (^)(UIActionSheet *sender))block{
    [self addButtonWithTitle:title handler:block];
    self.cancelButtonIndex = self.numberOfButtons - 1;
}

- (void) addDestructiveButtonWithTitle:(NSString*)title handler:(void (^)(UIActionSheet *sender))block{
    [self addButtonWithTitle:title handler:block];
    self.destructiveButtonIndex = self.numberOfButtons - 1;
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    id block = buttonIndex < self.actions.count ? self.actions[buttonIndex] : nil;
    
    if(block == [NSNull null] || !block) return;
    
    UIActionSheetBlock handler = block;
	
    handler(self);
    
    
}


@end
