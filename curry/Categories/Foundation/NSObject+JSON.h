//
//  NSObject+JSON.h
//  curry
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

@import Foundation;

@interface NSObject (JSON)


#if NS_BLOCKS_AVAILABLE

typedef void (^TKJSONCompletionBlock)(id object,NSError *error);

/** Process JSON data in the background with a completion block.
 @param data The JSON data.
 @param block The block that will be performed upon the parsing of the json data. The process data will be included as an object with the selector.
 */
- (void) processJSON:(NSData*)data withCompletion:(TKJSONCompletionBlock)block;

/** Process JSON data in the background with a completion block.
 @param data The JSON data.
 @param options An json parsing options to be included will parsing the JSON data.
 @param block The block that will be performed upon the parsing of the json data. The process data will be included as an object with the selector.
 */
- (void) processJSON:(NSData*)data options:(NSJSONReadingOptions)options withCompletion:(TKJSONCompletionBlock)block;

#endif



@end
