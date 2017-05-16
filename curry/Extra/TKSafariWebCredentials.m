//
//  TKSafariWebCredentials.m
//  Created by Devin Ross on 5/6/17.
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

#import "TKSafariWebCredentials.h"
@import Security;

@implementation TKSafariWebCredentials

+ (void) getSafariCredentialsWithURL:(NSURL*)url failure:(void(^)(NSError *error))failure success:(void(^)(NSString *username, NSString *password))success{
	
	
	NSString *host = url.host;
	
	SecRequestSharedWebCredential( (__bridge CFStringRef)host, NULL, ^(CFArrayRef credentials, CFErrorRef error) {
		
		if (error != NULL) {
			// If an error occurs, handle the error here.
			dispatch_async(dispatch_get_main_queue(), ^{
				if(failure)
					failure((__bridge NSError *)error);
			});
			return;
		}
		
		CFStringRef server = NULL;
		NSString *userName = nil;
		NSString *password = nil;
		
		// If credentials are found, use them.
		if (CFArrayGetCount(credentials) > 0) {
			
			// There will only ever be one credential dictionary
			CFDictionaryRef credentialDict = CFArrayGetValueAtIndex(credentials, 0);
			
			server = CFDictionaryGetValue(credentialDict, kSecAttrServer);
			userName = [(__bridge NSString *)CFDictionaryGetValue(credentialDict, kSecAttrAccount) copy];
			password = [(__bridge NSString *)CFDictionaryGetValue(credentialDict, kSecSharedPassword) copy];
			
			// Attempt to log in
			
			dispatch_async(dispatch_get_main_queue(), ^{
				if(success)
					success(userName,password);
			});
			
		}else{
			
			dispatch_async(dispatch_get_main_queue(), ^{
				if(failure)
					failure(nil);
			});

		}
		
		
	});
	
}

+ (void) updateSafariCredentialsWithURL:(NSURL*)url email:(NSString*)email password:(NSString*)password failure:(void(^)(NSError *error))failure success:(void(^)(void)) success{
	
	NSString *host = url.host;

	SecAddSharedWebCredential( (__bridge CFStringRef)host, (__bridge CFStringRef)email,  (__bridge CFStringRef)password, ^(CFErrorRef error) {
		
		if (error != NULL) {
			// Handle the error here...
			dispatch_async(dispatch_get_main_queue(), ^{
				if(failure)
					failure((__bridge NSError *)error);
			});
			return;
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if(success)
				success();
		});
		
	});
	
}

+ (NSString*) generateSafariPassword{
	return CFBridgingRelease(SecCreateSharedWebCredentialPassword());
}


@end
