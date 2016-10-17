//
//  NSStringAddition.h
//  Created by Devin Ross on 10/26/09.
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

/** Additional functionality for `NSString`.  */
@interface NSString (TKCategory)


/** Returns `YES` if a string is a valid email address, otherwise `NO`. 
 @return True if the string is formatted properly as an email address.
 */
@property (nonatomic, getter=isEmail, readonly) BOOL email;


/** Returns a `NSString` that removes blank space from the start and end of string.
 @return A stripped string.
 */
@property (nonatomic, readonly, copy) NSString *stripWhitespace;

/** Returns a `NSString` that removes blank space and new lines from the start and end of string.
 @return A stripped string.
 */
@property (nonatomic, readonly, copy) NSString *stripWhitepspaceAndNewlines;

/** Returns a `NSString` that is URL friendly. 
 @return A URL encoded string.
 */
@property (nonatomic, readonly, copy) NSString *URLEncode;

/** Returns a `NSString` that properly replaces HTML specific character sequences. 
 @return An escaped HTML string.
 */
@property (nonatomic, readonly, copy) NSString *escapeHTML;

/** Returns a `NSString` that properly formats text for HTML. 
 @return An unescaped HTML string.
 */
@property (nonatomic, readonly, copy) NSString *unescapeHTML;

/** Returns a `NSString` that removes HTML elements. 
 @return Returns a string without the HTML elements. 
 */
@property (nonatomic, readonly, copy) NSString *stringByRemovingHTML;

/** Returns an MD5 string of from the given `NSString`. 
 @return A MD5 string.
 */
@property (nonatomic, readonly, copy) NSString *md5sum;

/** Returns `YES` is a string has the substring, otherwise `NO`. 
 @param substring The substring.
 @return `YES` if the substring is contained in the string, otherwise `NO`.
 */
- (BOOL) hasString:(NSString*)substring;


/** Returns the length of the string minus the whitespace characters.
 @return Returns the length of the string minus the whitespace characters.
 */
@property (nonatomic, readonly) NSUInteger lengthWithoutWhitespace;

/** Returns a string without the whitespace characters.
 @return Returns a string without the whitespace characters.
 */
@property (nonatomic, readonly) NSString *stringWithoutWhitespace;



/* Returns a string with the first word in each sentence as capitalized. */
@property (nonatomic, readonly, copy) NSString *capitalizeSentence;


/** Returns the credit card type based on the first for digits of the card number.
 @return A credit card company name if the number matches a company otherwise nil.
 */
@property (nonatomic, readonly, copy) NSString *creditCardType;

/** Returns YES if the card number passes the Luhn algorithm. No spaces in the card number.
 @return Returns YES if the card is a valid credit card number, otherwise NO.
 */
@property (nonatomic, getter=isValidCreditCardNumber, readonly) BOOL validCreditCardNumber;

/** Returns a formatted phone number. So it'd transform a string 18005555555 would be 1-800-555-5555.
 @param deleteLastChar Remove the last character from the string.
 @return Returns an `NSString` that transform a string of numbers into a string human readable phone number.
 */
- (NSString*) formattedPhoneNumberWithLastCharacterRemoved:(BOOL)deleteLastChar;


- (NSString*) formattedPhoneNumberWithLastCharacterRemoved:(BOOL)deleteLastChar limit:(NSInteger)limit;


@end
