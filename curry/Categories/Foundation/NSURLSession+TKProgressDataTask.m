//
//  NSURLSession+TKProgressDataTask.m
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


#import "NSURLSession+TKProgressDataTask.h"
#import "NSObject+JSON.h"

@interface TKProgressDataTask ()

@property (nonatomic,strong) NSURLSessionDataTask *task;
@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic,strong) NSMutableData *data;
@property (nonatomic,assign) BOOL shouldProcessJSON;

@end


@implementation NSURLSession (TKProgressDataTask)

+ (TKProgressDataTask* _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
										 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse  * _Nullable response, NSError * _Nullable error))completionHandler{
	
	TKProgressDataTask *task = [TKProgressDataTask progressDataTaskWithURL:url progressHandler:progressHandler completionHandler:completionHandler];
	return task;
}

+ (TKProgressDataTask* _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
								   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [TKProgressDataTask progressDataTaskWithURL:url uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}

+ (TKProgressDataTask* _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
										 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [TKProgressDataTask progressDataTaskWithURL:url progressHandler:progressHandler uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}




+ (TKProgressDataTask* _Nonnull) progressDataTaskWithRequest:(NSURLRequest*)request
										 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse  * _Nullable response, NSError * _Nullable error))completionHandler{
	
	TKProgressDataTask *task = [TKProgressDataTask progressDataTaskWithRequest:request
															   progressHandler:progressHandler
															 completionHandler:completionHandler];
	return task;
}

+ (TKProgressDataTask* _Nonnull) progressDataTaskWithRequest:(NSURLRequest*)request
								   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [TKProgressDataTask progressDataTaskWithRequest:request
														 uploadProgressHandler:uploadProgressHandler
															 completionHandler:completionHandler];
	return task;
}

+ (TKProgressDataTask* _Nonnull) progressDataTaskWithRequest:(NSURLRequest*)request
										 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [TKProgressDataTask progressDataTaskWithRequest:request
															   progressHandler:progressHandler
														 uploadProgressHandler:uploadProgressHandler
															 completionHandler:completionHandler];
	return task;
}










+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
										 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									   completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse  * _Nullable response, NSError * _Nullable error))completionHandler{
	
	TKProgressDataTask *task = [TKProgressDataTask progressJSONDataTaskWithURL:url progressHandler:progressHandler completionHandler:completionHandler];
	return task;
}

+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
								   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									   completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [TKProgressDataTask progressJSONDataTaskWithURL:url uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}

+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
										 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									   completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [TKProgressDataTask progressJSONDataTaskWithURL:url progressHandler:progressHandler uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}




+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest*)request
											 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
										   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse  * _Nullable response, NSError * _Nullable error))completionHandler{
	
	TKProgressDataTask *task = [TKProgressDataTask progressJSONDataTaskWithRequest:request
															   progressHandler:progressHandler
															 completionHandler:completionHandler];
	return task;
}

+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest*)request
									   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
										   completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [TKProgressDataTask progressJSONDataTaskWithRequest:request
														 uploadProgressHandler:uploadProgressHandler
															 completionHandler:completionHandler];
	return task;
}

+ (TKProgressDataTask* _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest*)request
											 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
										   completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [TKProgressDataTask progressJSONDataTaskWithRequest:request
															   progressHandler:progressHandler
														 uploadProgressHandler:uploadProgressHandler
															 completionHandler:completionHandler];
	return task;
}


@end

@implementation TKProgressDataTask


+ (instancetype _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
								  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithDataTaskWithURL:url progressHandler:progressHandler uploadProgressHandler:nil completionHandler:completionHandler];
	return task;
}


+ (instancetype _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
								  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
							uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
								completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithDataTaskWithURL:url progressHandler:progressHandler uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}

+ (instancetype _Nonnull) progressDataTaskWithURL:(NSURL* _Nonnull)url
							uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
								completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithDataTaskWithURL:url progressHandler:nil uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}


+ (instancetype _Nonnull) progressDataTaskWithRequest:(NSURLRequest*)request
								  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithDataTaskWithRequest:request progressHandler:progressHandler uploadProgressHandler:nil completionHandler:completionHandler];
	return task;
}


+ (instancetype _Nonnull) progressDataTaskWithRequest:(NSURLRequest*)request
								  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
							uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
								completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithDataTaskWithRequest:request progressHandler:progressHandler uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}

+ (instancetype _Nonnull) progressDataTaskWithRequest:(NSURLRequest*)request
							uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
								completionHandler:(void (^ __nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithDataTaskWithRequest:request progressHandler:nil uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}






+ (instancetype _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
								  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithJSONDataTaskWithURL:url progressHandler:progressHandler uploadProgressHandler:nil completionHandler:completionHandler];
	return task;
}


+ (instancetype _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
								  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
							uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
								completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithJSONDataTaskWithURL:url progressHandler:progressHandler uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}

+ (instancetype _Nonnull) progressJSONDataTaskWithURL:(NSURL* _Nonnull)url
							uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
								completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithJSONDataTaskWithURL:url progressHandler:nil uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}


+ (instancetype _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest*)request
									  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
									completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithJSONDataTaskWithRequest:request progressHandler:progressHandler uploadProgressHandler:nil completionHandler:completionHandler];
	return task;
}


+ (instancetype _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest*)request
									  progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
								uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithJSONDataTaskWithRequest:request progressHandler:progressHandler uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}

+ (instancetype _Nonnull) progressJSONDataTaskWithRequest:(NSURLRequest*)request
								uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
									completionHandler:(void (^ __nullable)(id _Nullable data, NSURLResponse * _Nullable response, NSError  * _Nullable error))completionHandler{
	TKProgressDataTask *task = [[TKProgressDataTask alloc] initWithJSONDataTaskWithRequest:request progressHandler:nil uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	return task;
}






#pragma mark Base Inits
- (instancetype) initWithDataTaskWithURL:(NSURL*)url
						 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
				   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
					   completionHandler:(void (^ __nullable)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
	if(!(self=[super init])) return nil;
	
	[self setupWithProgressHandler:progressHandler uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	self.task = [self.session dataTaskWithURL:url];
	
	return self;
}

- (instancetype) initWithDataTaskWithRequest:(NSURLRequest*)request
						 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
				   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
					   completionHandler:(void (^ __nullable)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
	if(!(self=[super init])) return nil;
	
	[self setupWithProgressHandler:progressHandler uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	self.task = [self.session dataTaskWithRequest:request];
	
	return self;
}


- (instancetype) initWithJSONDataTaskWithURL:(NSURL*)url
						 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
				   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
					   completionHandler:(void (^ __nullable)(id data, NSURLResponse *response, NSError *error))completionHandler{
	if(!(self=[super init])) return nil;
	
	self.shouldProcessJSON = YES;
	[self setupWithProgressHandler:progressHandler uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	self.task = [self.session dataTaskWithURL:url];
	
	return self;
}

- (instancetype) initWithJSONDataTaskWithRequest:(NSURLRequest*)request
							 progressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
					   uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
						   completionHandler:(void (^ __nullable)(id data, NSURLResponse *response, NSError *error))completionHandler{
	if(!(self=[super init])) return nil;
	
	self.shouldProcessJSON = YES;
	[self setupWithProgressHandler:progressHandler uploadProgressHandler:uploadProgressHandler completionHandler:completionHandler];
	self.task = [self.session dataTaskWithRequest:request];
	
	return self;
}


- (void) setupWithProgressHandler:(void (^ __nullable)(double loadedDataSize, double expectedDataSize))progressHandler
			uploadProgressHandler:(void (^ __nullable)(double uploadedDataSize, double expectedUploadedDataSize))uploadProgressHandler
				completionHandler:(void (^ __nullable)(id data, NSURLResponse *response, NSError *error))completionHandler{
	
	
	self.data = [[NSMutableData alloc] init];
	
	self.progressHandler = progressHandler;
	self.uploadProgressHandler = uploadProgressHandler;
	self.completionHandler = completionHandler;
	
	NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
	self.session = session;
}

- (void) dealloc{
	self.data = nil;
	self.progressHandler = nil;
	self.completionHandler = nil;
	self.task = nil;
	[self.session finishTasksAndInvalidate];
	self.session = nil;
}

#pragma mark GIF Loading
- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
	dispatch_async(dispatch_get_main_queue(), ^{
		if(self.uploadProgressHandler)
			self.uploadProgressHandler((double)totalBytesSent, (double)totalBytesExpectedToSend);
	});
}
- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
	completionHandler(NSURLSessionResponseAllow);
	self.expectedData = response.expectedContentLength;
	dispatch_async(dispatch_get_main_queue(), ^{
		self.progressHandler(0, (double)self.expectedData);
	});
}
- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
	[self.data appendData:data];
	dispatch_async(dispatch_get_main_queue(), ^{
		self.progressHandler(self.data.length, (double)self.expectedData);
	});
}
- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
	dispatch_async(dispatch_get_main_queue(), ^{
		if(self.completionHandler){
			if(self.shouldProcessJSON){
				[self processJSON:self.data response:task.response error:error options:0 withCompletion:^(id object, NSURLResponse *response, NSError *error) {
					self.completionHandler(object, response, error);
					self.data = nil;
					self.progressHandler = nil;
					self.completionHandler = nil;
					self.task = nil;
					[self.session finishTasksAndInvalidate];
					self.session = nil;
				}];
			}else{
				self.completionHandler(self.data, task.response, error);
				self.data = nil;
				self.progressHandler = nil;
				self.completionHandler = nil;
				self.task = nil;
				[self.session finishTasksAndInvalidate];
				self.session = nil;
			}
		}
	});
}


- (void) resume{
	[self.task resume];
}
- (void) suspend{
	[self.task suspend];
}
- (void) cancel{
	[self.task cancel];
	self.data = nil;
}
- (float) priority{
	return self.task.priority;
}
- (void) setPriority:(float)priority{
	self.task.priority = priority;
}


@end
