//
//  NSURLRequest+TKCategory.m
//  Created by Devin Ross on 10/30/18.
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

#import "NSURLRequest+TKCategory.h"

@implementation NSURLRequest (TKCategory)


- (NSString *) curlString{
	
	__block NSMutableString *displayString = [NSMutableString stringWithFormat:@"curl -v -X %@", self.HTTPMethod];
	
	[displayString appendFormat:@" \'%@\'",  self.URL.absoluteString];
	
	[self.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(id key, id val, BOOL *stop) {
		[displayString appendFormat:@" -H \'%@: %@\'", key, val];
	}];
	
	if ([self.HTTPMethod isEqualToString:@"POST"] ||
		[self.HTTPMethod isEqualToString:@"PUT"] ||
		[self.HTTPMethod isEqualToString:@"PATCH"]) {
		
		[displayString appendFormat:@" -d \'%@\'",
		 [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding]];
	}
	
	return displayString;
}




@end
