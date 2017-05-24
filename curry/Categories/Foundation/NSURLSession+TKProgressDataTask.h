//
//  NSURLSession+TKProgressDataTask.h
//  Created by Devin Ross on 5/2/17.
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

@class TKProgressDataTask;

@interface NSURLSession (TKProgressDataTask)

#pragma mark URL
+ (TKProgressDataTask* _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
										 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse  * _Nullable response, NSError * _Nullable error))completionHandler;

+ (TKProgressDataTask* _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
								   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

+ (TKProgressDataTask* _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
										 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

#pragma mark Request
+ (TKProgressDataTask* _Nonnull) progressDataTaskWithRequest:(NSURLRequest* _Nonnull)request
											 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
										   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse  * _Nullable response, NSError * _Nullable error))completionHandler;

+ (TKProgressDataTask* _Nonnull) progressDataTaskWithRequest:(NSURLRequest* _Nonnull)request
									   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
										   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

+ (TKProgressDataTask* _Nonnull) progressDataTaskWithRequest:(NSURLRequest* _Nonnull)request
											 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
										   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;




#pragma mark JSON URL
+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
											 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
										   completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse  * _Nullable response, NSError * _Nullable error))completionHandler;

+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
									   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
										   completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
											 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
										   completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;



#pragma mark JSON Request
+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest* _Nonnull)request
												 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
											   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse  * _Nullable response, NSError * _Nullable error))completionHandler;

+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest* _Nonnull)request
										   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
											   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest* _Nonnull)request
												 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
										   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
											   completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;



@end



@interface TKProgressDataTask : NSObject <NSURLSessionDelegate>

#pragma mark URL
+ (instancetype _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
								  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

+ (instancetype _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
							uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

+ (instancetype _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
								  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
							uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
								completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

#pragma mark Request
+ (instancetype _Nonnull) progressDataTaskWithRequest:(NSURLRequest* _Nonnull)request
									  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

+ (instancetype _Nonnull) progressDataTaskWithRequest:(NSURLRequest* _Nonnull)request
									  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

+ (instancetype _Nonnull) progressDataTaskWithRequest:(NSURLRequest* _Nonnull)request
								uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;



#pragma mark JSON URL
+ (instancetype _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
									  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;


+ (instancetype _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
									  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

+ (instancetype _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
								uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

#pragma mark JSON Request
+ (instancetype _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest* _Nonnull)request
										  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
										completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;


+ (instancetype _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest* _Nonnull)request
										  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
										completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;

+ (instancetype _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest* _Nonnull)request
									uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
										completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler;




@property (nonatomic,assign) double expectedData;
@property (nonatomic,assign) double loadedData;

@property (nonatomic,copy) void (^ _Nullable completionHandler)(id _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);
@property (nonatomic,copy) void (^ _Nullable progressHandler)(double loadedDataSize, double expectedDataSize);
@property (nonatomic,copy) void (^ _Nullable uploadProgressHandler)(double uploadedDataSize, double expectedUploadedDataSize);

@property (nonatomic,assign) float priority;

- (void) resume;
- (void) suspend;
- (void) cancel;

@end
