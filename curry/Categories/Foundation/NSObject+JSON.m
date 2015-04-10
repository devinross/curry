//
//  NSObject+JSON.m
//  curry
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "NSObject+JSON.h"

@implementation NSObject (JSON)


#pragma mark Process JSON in Background
#if NS_BLOCKS_AVAILABLE
- (void) processJSON:(NSData*)data withCompletion:(TKJSONCompletionBlock)block{
    [self processJSON:data options:0 withCompletion:block];
}

- (void) processJSON:(NSData*)data options:(NSJSONReadingOptions)options withCompletion:(TKJSONCompletionBlock)block{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        
        NSError *error;
        id object = [NSJSONSerialization JSONObjectWithData:data options:options error:&error];
        dispatch_sync(dispatch_get_main_queue(), ^{
            block(object,error);
        });
    });
    
}
#endif







@end
