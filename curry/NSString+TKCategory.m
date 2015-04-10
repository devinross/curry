//
//  NSStringAddition.m
//  Created by Devin Ross on 10/26/09.
//
/*
 
 tapku || http://github.com/devinross/tapkulibrary
 
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

#import "NSString+TKCategory.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TKCategory)


- (NSString*) creditCardType{
	if(self.length < 4) return nil;

	NSString *firstTwo = [self substringToIndex:2];
	NSInteger value = firstTwo.integerValue;
	
	if(value == 34 || value == 37)
		return NSLocalizedString(@"American Express", @"");
	
	else if(value == 36)
		return NSLocalizedString(@"Diners Club", @"");
	
	else if(value == 38)
		return NSLocalizedString(@"Carte Blanche", @"");
	
	else if(value > 50 && value < 56)
		return NSLocalizedString(@"Master Card", @"");
	

	
	
		
	NSString *firstFour = [self substringToIndex:4];
	value = firstFour.integerValue;
	
	
	if(value == 2014 || value == 2149)
		return NSLocalizedString(@"EnRoute", @"");
	
	else if(value == 2131 || value == 1800)
		return NSLocalizedString(@"JCB", @"");
	
	else if(value == 6011)
		return NSLocalizedString(@"Discover", @"");
		
		

	
	NSString *firstThree = [self substringToIndex:3];
	value = firstThree.integerValue;
	
	if(value >= 300 && value < 306) return NSLocalizedString(@"Diners Club", @"");
	
	NSString *firstOne = [self substringToIndex:1];
	value = firstOne.integerValue;
	
	if(value == 3) return NSLocalizedString(@"JCB", @"");
	
	else if(value == 4) return NSLocalizedString(@"Visa", @"");
	

	return NSLocalizedString(@"Unknown", @"");
}


- (BOOL) isValidCreditCardNumber{
	
	NSCharacterSet *nonDecimalsSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
	
	if([self rangeOfCharacterFromSet:nonDecimalsSet].location != NSNotFound)
		return NO;
	
	
	
	
	
	NSInteger luhnChecksum = 0;
	NSInteger subtractionNumber = 48;
	
	for (NSInteger i=0;i<self.length;i++){
		
		NSUInteger count = self.length-1;
		NSInteger doubled = [@([self characterAtIndex:count-i]) integerValue] - subtractionNumber;
		if (i % 2) doubled = doubled*2;
		
		NSString *doubleDigit = [NSString stringWithFormat:@"%@",@(doubled)];
		
		if (doubleDigit.length > 1){
			luhnChecksum += [@([doubleDigit characterAtIndex:0]) integerValue]-subtractionNumber;
			luhnChecksum += [@([doubleDigit characterAtIndex:1]) integerValue]-subtractionNumber;
		}else{
			luhnChecksum += doubled;
		}
	}
	
	
	return luhnChecksum % 10 == 0;
}





- (NSString*) capitalizeSentence{
	if(self.length < 1) return self;
	
	return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[self substringToIndex:1].capitalizedString];
}

- (BOOL) isEmail{
	
    NSString *emailRegEx =
	@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"  
	@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"  
	@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"; 
	
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];  
    return [regExPredicate evaluateWithObject:[self lowercaseString]];  
}

- (NSString*) URLEncode{
	
	NSString *encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
																						   NULL,
																						   (__bridge CFStringRef)self,
																						   NULL,
																						   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																						   kCFStringEncodingUTF8 );
	
	return encodedString;
	
}


- (NSString *) escapeHTML{
	NSMutableString *s = [NSMutableString string];
	
	NSInteger start = 0;
	NSInteger len = [self length];
	NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
	
	while (start < len) {
		NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len-start)];
		if (r.location == NSNotFound) {
			[s appendString:[self substringFromIndex:start]];
			break;
		}
		
		if (start < r.location) {
			[s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
		}
		
		switch ([self characterAtIndex:r.location]) {
			case '<':
				[s appendString:@"&lt;"];
				break;
			case '>':
				[s appendString:@"&gt;"];
				break;
			case '"':
				[s appendString:@"&quot;"];
				break;
				//			case '…':
				//				[s appendString:@"&hellip;"];
				//				break;
			case '&':
				[s appendString:@"&amp;"];
				break;
		}
		
		start = r.location + 1;
	}
	
	return s;
}

- (NSString *) unescapeHTML{
	NSMutableString *s = [NSMutableString string];
	NSMutableString *target = [self mutableCopy];
	NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];
	
	while ([target length] > 0) {
		NSRange r = [target rangeOfCharacterFromSet:chs];
		if (r.location == NSNotFound) {
			[s appendString:target];
			break;
		}
		
		if (r.location > 0) {
			[s appendString:[target substringToIndex:r.location]];
			[target deleteCharactersInRange:NSMakeRange(0, r.location)];
		}
		
		if ([target hasPrefix:@"&lt;"]) {
			[s appendString:@"<"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&gt;"]) {
			[s appendString:@">"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&quot;"]) {
			[s appendString:@"\""];
			[target deleteCharactersInRange:NSMakeRange(0, 6)];
		} else if ([target hasPrefix:@"&#39;"]) {
			[s appendString:@"'"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		} else if ([target hasPrefix:@"&amp;"]) {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		} else if ([target hasPrefix:@"&hellip;"]) {
			[s appendString:@"…"];
			[target deleteCharactersInRange:NSMakeRange(0, 8)];
		} else {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 1)];
		}
	}
	return s;
}

- (NSString*) stringByRemovingHTML{
	
	NSString *html = self;
    NSScanner *thescanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([thescanner isAtEnd] == NO) {
		[thescanner scanUpToString:@"<" intoString:NULL];
		[thescanner scanUpToString:@">" intoString:&text];
		html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@" "];
    }
	return html;
}

- (NSString *) md5sum{
	unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
	CC_MD5([self UTF8String], (uint32_t)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	for (i=0;i<CC_MD5_DIGEST_LENGTH;i++) {
		[ms appendFormat: @"%02x", (int)(digest[i])];
	}
	return [ms copy];
}

- (BOOL) hasString:(NSString*)substring{
	return !([self rangeOfString:substring].location == NSNotFound);
}





- (NSString*) formattedPhoneNumberWithLastCharacterRemoved:(BOOL)deleteLastChar{
	if(self.length<1) return @"";
	
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-\\(\\)]" options:NSRegularExpressionCaseInsensitive error:&error];
	NSString *digits = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
	
	
	// should we delete the last digit?
	if(deleteLastChar) 
		digits = [digits substringToIndex:digits.length - 1];

	
	// 123 456 7890
	// format the number.. if it's less then 7 digits.. then use this regex.
	BOOL leadingOne = [digits hasPrefix:@"1"];

	if((digits.length > 11 && leadingOne) || (digits.length > 10 && !leadingOne))
		return digits;
	
	NSStringCompareOptions opt = NSRegularExpressionSearch;
	NSRange range = NSMakeRange(0, digits.length);
	
	NSString *occurence, *replace;

	
	if(digits.length < 5 && leadingOne){
		occurence = @"(\\d{1})(\\d+)";
		replace = @"$1 ($2)";
		
	}else if(digits.length < 8 && leadingOne){
		occurence = @"(\\d{1})(\\d{3})(\\d+)";
		replace = @"$1 ($2) $3";
		
	}else if(digits.length<7){
		occurence = @"(\\d{3})(\\d+)";
		replace = @"($1) $2";
		
	}else if(digits.length > 6 && leadingOne){
		occurence = @"(\\d{1})(\\d{3})(\\d{3})(\\d+)";
		replace = @"$1 ($2) $3-$4";
		
	}else{
		occurence = @"(\\d{3})(\\d{3})(\\d+)";
		replace = @"($1) $2-$3";
	}

	digits = [digits stringByReplacingOccurrencesOfString:occurence withString:replace options:opt range:range];

	return digits;
}


@end
