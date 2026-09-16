//
//  NSStringTests.swift
//  Created by Devin on 7/18/12.
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

import XCTest
import curry


final class NSStringTests: XCTestCase {
	
	func testShouldValidateEmailAddress() {
		
		XCTAssertTrue(("bob@sanders.com" as NSString).isEmail, "Expected to be a valid email")
		XCTAssertTrue(("ao123sda.b2132Ob@sAND123123dsadrs.c" as NSString).isEmail, "Expected to be a valid email")
		
		XCTAssertFalse(("ao,sda.bOb@sANDdsadrs.c" as NSString).isEmail, "Expected to be an invalid email")
		XCTAssertFalse(("" as NSString).isEmail, "Expected to be an invalid email")
		XCTAssertFalse(("@b.d" as NSString).isEmail, "Expected to be an invalid email")
		
		for bad in ["hello#bob@bee.com", "hello|bob@bee.com", "hello!bob@bee.com",
		            "hello<bob@bee.com", "hello>bob@bee.com", "hello[bob@bee.com",
		            "hello]bob@bee.com", "hello(bob@bee.com", "hello)bob@bee.com"] {
			XCTAssertFalse((bad as NSString).isEmail, "Expected \(bad) to be an invalid email")
		}
	}
	
	func testShouldGenerateMD5Sum() {
		XCTAssertEqual(("password" as NSString).md5sum, "5f4dcc3b5aa765d61d8327deb882cf99")
		XCTAssertEqual(("devin" as NSString).md5sum, "11ef1590a74e1ab26c31a4e13f52d71b")
	}
	
	func testShouldCountWhitespaceCorrectly() {
		XCTAssertEqual(("hello" as NSString).lengthWithoutWhitespace, 5)
		XCTAssertEqual(("hello bob" as NSString).lengthWithoutWhitespace, 8)
		XCTAssertEqual((" 1h!sh #72 " as NSString).lengthWithoutWhitespace, 8)
		XCTAssertEqual(("" as NSString).lengthWithoutWhitespace, 0)
		XCTAssertEqual(("      \n\t" as NSString).lengthWithoutWhitespace, 0)
	}
	
	func testShouldHaveStripWhitespace() {
		let result = "This is the final result string."
		XCTAssertEqual(("   \(result)    " as NSString).stripWhitespace, result)
		XCTAssertEqual(("\n \t   \(result)    \n \t " as NSString).stripWhitepspaceAndNewlines, result)
	}
	
	func testShouldEncodeString() {
		
		let cases: [(String, String)] = [
			("", ""), ("Bob Sanders", "Bob%20Sanders"), (";", "%3B"), ("?", "%3F"),
			("/", "%2F"), (":", "%3A"), ("#", "%23"), ("&", "%26"), (" ", "%20"),
			("=", "%3D"), ("+", "%2B"), ("$", "%24"), (",", "%2C"), ("%", "%25"),
			("<", "%3C"), (">", "%3E"), ("~", "%7E"),
			(";?/:#& =+$,%<>~%", "%3B%3F%2F%3A%23%26%20%3D%2B%24%2C%25%3C%3E%7E%25"),
			("\"Aardvarks lurk, OK?\"", "%22Aardvarks%20lurk%2C%20OK%3F%22"),
			("hasldlasda32-1^&", "hasldlasda32-1%5E%26"),
		]
		
		for (input, expected) in cases {
			XCTAssertEqual((input as NSString).URLEncode, expected, "encoding \(input)")
		}
	}
	
	func testShouldHaveString() {
		XCTAssertTrue(("Bob Sanders" as NSString).hasString("Sanders"))
		XCTAssertFalse(("Bob Sanders" as NSString).hasString("SANDERS"))
		XCTAssertFalse(("Bob Sanders" as NSString).hasString("Cooper"))
	}
	
	func testShouldPassCreditCardValidation() {
		
		XCTAssertNil(("12" as NSString).creditCardType, "Card number not long enough")
		XCTAssertEqual(("12HelloGuys" as NSString).creditCardType,
		               NSLocalizedString("Unknown", comment: ""), "Not a proper card")
		
		let cases: [(String, String)] = [
			("34085943", "American Express"), ("37085943", "American Express"),
			("378282246310005", "American Express"), ("371449635398431", "American Express"),
			("36085943", "Diners Club"),
			("38085943", "Carte Blanche"),
			("51085943", "Master Card"), ("52085943", "Master Card"), ("55085943", "Master Card"),
			("5555555555554444", "Master Card"), ("5105105105105100", "Master Card"),
			("20145943", "EnRoute"), ("21495943", "EnRoute"),
			("18005943", "JCB"), ("21315943", "JCB"),
			("60115943", "Discover"), ("6011111111111117", "Discover"), ("6011000990139424", "Discover"),
			("30095943", "Diners Club"), ("30195943", "Diners Club"), ("30595943", "Diners Club"),
			("30569309025904", "Diners Club"),
			("39595943", "JCB"), ("3530111333300000", "JCB"), ("3566002020360505", "JCB"),
			("49595943", "Visa"), ("4242424242424242", "Visa"), ("4012888888881881", "Visa"),
		]
		
		for (number, issuer) in cases {
			XCTAssertEqual((number as NSString).creditCardType,
			               NSLocalizedString(issuer, comment: ""), "for \(number)")
		}
	}
	
	func testShouldValidateCreditCard() {
		XCTAssertTrue(("4242424242424242" as NSString).isValidCreditCardNumber)
		XCTAssertFalse(("4242424252424242" as NSString).isValidCreditCardNumber)
	}
	
	func testShouldFormatPhoneString() {
		
		let cases: [(String, String)] = [
			("2345678901", "(234) 567-8901"),
			("12345678901", "1 (234) 567-8901"),
			("123456789012", "123456789012"),
			("123", "1 (23)"),
			("1234", "1 (234)"),
			("12345", "1 (234) 5"),
			("12345678", "1 (234) 567-8"),
			("529112345678912", "529112345678912"),
		]
		
		for (input, expected) in cases {
			let output = (input as NSString).formattedPhoneNumber(withLastCharacterRemoved: false)
			XCTAssertEqual(output, expected, "formatting \(input)")
		}
	}
	
	func testShouldCapitalizeSentence() {
		let output = ("this is a sentence. this is another one." as NSString).capitalizeSentence
		XCTAssertEqual(output, "This is a sentence. this is another one.")
	}
	
}
