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

- (void) processJSONDataInBackground:(NSData *)data withCallbackSelector:(SEL)callback{
    
    [self processJSONDataInBackground:data
                 withCallbackSelector:callback
                   backgroundSelector:nil
                        errorSelector:nil
                       readingOptions:0];
    
}

- (void) processJSONDataInBackground:(NSData *)data withCallbackSelector:(SEL)callback readingOptions:(NSJSONReadingOptions)options{
    
    [self processJSONDataInBackground:data
                 withCallbackSelector:callback
                   backgroundSelector:nil
                        errorSelector:nil
                       readingOptions:options];
    
}

- (void) processJSONDataInBackground:(NSData *)data withCallbackSelector:(SEL)callback backgroundSelector:(SEL)backgroundProcessor readingOptions:(NSJSONReadingOptions)options{
    
    [self processJSONDataInBackground:data
                 withCallbackSelector:callback
                   backgroundSelector:backgroundProcessor
                        errorSelector:nil
                       readingOptions:options];
    
}

- (void) processJSONDataInBackground:(NSData *)data withCallbackSelector:(SEL)callback backgroundSelector:(SEL)backgroundProcessor errorSelector:(SEL)errroSelector{
    
    [self processJSONDataInBackground:data
                 withCallbackSelector:callback
                   backgroundSelector:backgroundProcessor
                        errorSelector:errroSelector
                       readingOptions:0];
    
}


- (void) processJSONDataInBackground:(NSData *)data
                withCallbackSelector:(SEL)callback
                  backgroundSelector:(SEL)backgroundProcessor
                       errorSelector:(SEL)errroSelector
                      readingOptions:(NSJSONReadingOptions)options{
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"data"] = data;
    dict[@"flags"] = @(options);
    
    
    if(callback) dict[@"callback"] = NSStringFromSelector(callback);
    if(backgroundProcessor) dict[@"backgroundProcessor"] = NSStringFromSelector(backgroundProcessor);
    if(errroSelector) dict[@"errroSelector"] = NSStringFromSelector(errroSelector);
    
    
    [self performSelectorInBackground:@selector(_processJSONData:) withObject:dict];
    
    
}


- (void) _processJSONData:(NSDictionary*)dict{
    @autoreleasepool {
        NSError *error = nil;
        
        NSData *data = dict[@"data"];
        NSUInteger options = [dict[@"flags"] unsignedIntValue];
        
        NSString *callback = dict[@"callback"];
        NSString *background = dict[@"backgroundProcessor"];
        NSString *eSelector = dict[@"errroSelector"];
        
        id object = [NSJSONSerialization JSONObjectWithData:data options:options error:&error];
        
        
        
        if(error && eSelector){
            [self performSelector:NSSelectorFromString(eSelector) withObject:error];
        }else if(!error){
            if(background) object = [self performSelector:NSSelectorFromString(background) withObject:object];
            [self performSelectorOnMainThread:NSSelectorFromString(callback) withObject:object waitUntilDone:NO];
        }
    }
}

@end
