//
//  NSObject+JSON.h
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

@import Foundation;

/** Additional functionality for `NSObject` that make it easy to turn `NSData` to json data on a background thread.  */
@interface NSObject (JSON)



typedef void (^TKJSONCompletionBlock)(id object,NSError *error);
typedef void (^TKJSONNetworkCompletionBlock)(id object,NSURLResponse *response,NSError *error);

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


- (void) processJSON:(NSData*)data response:(NSURLResponse *)response error:(NSError*)error options:(NSJSONReadingOptions)options withCompletion:(TKJSONNetworkCompletionBlock)block;





@end
