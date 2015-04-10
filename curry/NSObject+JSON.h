//
//  NSObject+JSON.h
//  curry
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import <Foundation/Foundation.h>

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

/** Process JSON data in the background with a callback selector.
 @param data The JSON data.
 @param callback The selector that will be performed upon the parsing of the json data. The process data will be included as an object with the selector.
 */
- (void) processJSONDataInBackground:(NSData *)data withCallbackSelector:(SEL)callback;

/** Process JSON data in the background with a callback selector.
 @param data The JSON data.
 @param callback The selector that will be performed upon the parsing of the json data. The process data will be included as an object with the selector.
 @param options An json parsing options to be included will parsing the JSON data.
 */
- (void) processJSONDataInBackground:(NSData *)data withCallbackSelector:(SEL)callback readingOptions:(NSJSONReadingOptions)options;

/** Process JSON data in the background with a callback selector.
 @param data The JSON data.
 @param callback The selector that will be performed upon the parsing of the json data. The process data will be included as an object with the selector.
 @param backgroundProcessor The selector that will be performed in the background upon the parsing of the json data. The process data will be included as an object with the selector. This selector must return some type of object to be passed to the callback selector.
 @param options An json parsing options to be included will parsing the JSON data.
 */
- (void) processJSONDataInBackground:(NSData *)data withCallbackSelector:(SEL)callback backgroundSelector:(SEL)backgroundProcessor readingOptions:(NSJSONReadingOptions)options;

/** Process JSON data in the background with a callback selector.
 @param data The JSON data.
 @param callback The selector that will be performed upon the parsing of the json data. The process data will be included as an object with the selector.
 @param backgroundProcessor The selector that will be performed in the background upon the parsing of the json data. The process data will be included as an object with the selector. This selector must return some type of object to be passed to the callback selector.
 @param errroSelector The selector that will be called upon if there is an error parsing the data.
 */
- (void) processJSONDataInBackground:(NSData *)data withCallbackSelector:(SEL)callback backgroundSelector:(SEL)backgroundProcessor errorSelector:(SEL)errroSelector;

/** Process JSON data in the background with a callback selector.
 @param data The JSON data.
 @param callback The selector that will be performed upon the parsing of the json data. The process data will be included as an object with the selector.
 @param backgroundProcessor The selector that will be performed in the background upon the parsing of the json data. The process data will be included as an object with the selector. This selector must return some type of object to be passed to the callback selector.
 @param errroSelector The selector that will be called upon if there is an error parsing the data.
 @param options An json parsing options to be included will parsing the JSON data.
 */
- (void) processJSONDataInBackground:(NSData *)data withCallbackSelector:(SEL)callback backgroundSelector:(SEL)backgroundProcessor errorSelector:(SEL)errroSelector readingOptions:(NSJSONReadingOptions)options;


@end
