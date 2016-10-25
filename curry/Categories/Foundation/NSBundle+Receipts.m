//
//  NSBundle+Receipts.m
//  Created by Devin Ross on 10/25/16.
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

#import "NSBundle+Receipts.h"
#import "NSURLSession+TKCategory.h"

@implementation NSBundle (Receipts)


- (void) requestReceiptWithURL:(NSURL*)url receiptData:(NSData*)receiptData Completion:(void(^)(id object, NSURLResponse *response, NSError *error))completion{
	
	NSString *data = [receiptData base64EncodedStringWithOptions:0];
	NSError *error = nil;
	NSData *requestData = [NSJSONSerialization dataWithJSONObject:@{ @"receipt-data" : data } options: 0 error:&error];
	NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:url];
	storeRequest.HTTPMethod = @"POST";
	storeRequest.HTTPBody = requestData;
	
	[[[NSURLSession sharedSession] jsonDataTaskWithRequest:storeRequest options:0 completionHandler:^(id object, NSURLResponse *response, NSError *error) {
		completion(object,response,error);
	}] resume];
	
}

- (void) requestReceiptOnAppStore:(void(^)(NSDictionary *receipt, NSURLResponse *response, NSError *error))completion{
	
	NSURL *receipt_url = [[NSBundle mainBundle] appStoreReceiptURL];
	NSData *receiptData = [NSData dataWithContentsOfURL:receipt_url];
	if(!receiptData){
		completion(nil,nil,nil);
		return;
	}
	
	NSURL *productionURL = [NSURL URLWithString:@"https://buy.itunes.apple.com/verifyReceipt"];
	[self requestReceiptWithURL:productionURL receiptData:receiptData Completion:^(id object, NSURLResponse *response, NSError *error) {
		if([object isKindOfClass:[NSDictionary class]] && [object[@"status"] intValue] == 21007){
			NSURL *sandboxURL = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
			[self requestReceiptWithURL:sandboxURL receiptData:receiptData Completion:^(id object, NSURLResponse *response, NSError *error) {
				completion(object, response, error);
			}];
			return;
		}
		completion(object, response, error);
	}];
	

}



@end
