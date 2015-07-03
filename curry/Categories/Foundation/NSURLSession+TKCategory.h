//
//  NSURLSession+TKCategory.h
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

/** Additional functionality for `NSURLSession` for getting json data. */
@interface NSURLSession (TKCategory)

/** Returns the object in the array with the lowest index value.
 @param request The `NSURLRequest` of the request.
 @param options JSON reading options.
 @param completion The block that is called upon completion.
 @return The `NSURLSessionDataTask` object.
 */
- (NSURLSessionDataTask*) jsonDataTaskWithRequest:(NSURLRequest*)request options:(NSJSONReadingOptions)options completionHandler:(void(^)(id object, NSURLResponse *response, NSError *error))completion;

/** Returns the object in the array with the lowest index value.
 @param URL The `NSURL` of the request.
 @param options JSON reading options.
 @param completion The block that is called upon completion.
 @return The `NSURLSessionDataTask` object.
 */
- (NSURLSessionDataTask*) jsonDataTaskWithURL:(NSURL*)URL options:(NSJSONReadingOptions)options completionHandler:(void(^)(id object, NSURLResponse *response, NSError *error))completion;

@end
