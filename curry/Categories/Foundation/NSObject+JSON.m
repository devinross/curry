//
//  NSObject+JSON.m
//  Created by Devin Ross on 4/10/15.
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

#import "NSObject+JSON.h"

@implementation NSObject (JSON)

#pragma mark Process JSON in Background
- (void) processJSON:(NSData*)data withCompletion:(TKJSONCompletionBlock)block{
    [self processJSON:data options:0 withCompletion:block];
}

- (void) processJSON:(NSData*)data response:(NSURLResponse *)response error:(NSError*)error options:(NSJSONReadingOptions)options withCompletion:(TKJSONNetworkCompletionBlock)block{
    
    if(error){
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if(block)
                block(nil,response,error);
        });
        return;
    }

    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        
        NSError *err;
        id object = [NSJSONSerialization JSONObjectWithData:data options:options error:&err];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(block)
                block(object,response,err);
        });
    });
    
}

- (void) processJSON:(NSData*)data options:(NSJSONReadingOptions)options withCompletion:(TKJSONCompletionBlock)block{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        
        NSError *error;
        id object = [NSJSONSerialization JSONObjectWithData:data options:options error:&error];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(block)
                block(object,error);
        });
    });
    
}


@end
