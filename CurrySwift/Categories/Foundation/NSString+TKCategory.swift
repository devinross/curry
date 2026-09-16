//
//  NSString+TKCategory.swift
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

import Foundation
import CryptoKit


/** Additional functionality for `NSString`. */
extension NSString {
	
	/** Returns `YES` if a string is a valid email address, otherwise `NO`.
	@return True if the string is formatted properly as an email address.
	*/
	@objc(isEmail)
	public var isEmail: Bool {
		
		let badCharacters = CharacterSet(charactersIn: " !\\#$%(),:;<>[]/`|")
		if rangeOfCharacter(from: badCharacters).location != NSNotFound {
			return false
		}
		
		let emailRegEx =
			"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}" +
			"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
			"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
			"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
			"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
			"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
			"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
		
		let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
		return predicate.evaluate(with: lowercased)
	}
	
	/** Returns a `NSString` that removes blank space from the start and end of string. */
	@objc public var stripWhitespace: String {
		trimmingCharacters(in: .whitespaces)
	}
	
	/** Returns a `NSString` that removes blank space and new lines from the start and end of string. */
	@objc public var stripWhitepspaceAndNewlines: String {
		trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	/** Returns a `NSString` that is URL friendly. */
	@objc public var URLEncode: String {
		var allowed = CharacterSet.urlQueryAllowed
		allowed.remove(charactersIn: ";?/:#& =+$,%<>~%")
		return addingPercentEncoding(withAllowedCharacters: allowed) ?? ""
	}
	
	/** Returns a `NSString` that properly replaces HTML specific character sequences. */
	@objc public var escapeHTML: String {
		
		let escaped = NSMutableString()
		let specials = CharacterSet(charactersIn: "<>&\"")
		let total = length
		var start = 0
		
		while start < total {
			
			let searchRange = NSRange(location: start, length: total - start)
			let found = rangeOfCharacter(from: specials, options: [], range: searchRange)
			
			guard found.location != NSNotFound else {
				escaped.append(substring(from: start))
				break
			}
			
			if start < found.location {
				escaped.append(substring(with: NSRange(location: start, length: found.location - start)))
			}
			
			switch character(at: found.location) {
				case 0x3C: escaped.append("&lt;")   // <
				case 0x3E: escaped.append("&gt;")   // >
				case 0x22: escaped.append("&quot;") // "
				case 0x26: escaped.append("&amp;")  // &
				default: break
			}
			
			start = found.location + 1
		}
		
		return escaped as String
	}
	
	/** Returns a `NSString` that properly formats text for HTML. */
	@objc public var unescapeHTML: String {
		
		let unescaped = NSMutableString()
		let target = NSMutableString(string: self as String)
		let ampersand = CharacterSet(charactersIn: "&")
		
		let entities: [(entity: String, replacement: String)] = [
			("&lt;", "<"),
			("&gt;", ">"),
			("&quot;", "\""),
			("&#39;", "'"),
			("&amp;", "&"),
			("&hellip;", "\u{2026}"),
		]
		
		while target.length > 0 {
			
			let found = target.rangeOfCharacter(from: ampersand)
			
			guard found.location != NSNotFound else {
				unescaped.append(target as String)
				break
			}
			
			if found.location > 0 {
				unescaped.append(target.substring(to: found.location))
				target.deleteCharacters(in: NSRange(location: 0, length: found.location))
			}
			
			if let match = entities.first(where: { target.hasPrefix($0.entity) }) {
				unescaped.append(match.replacement)
				target.deleteCharacters(in: NSRange(location: 0, length: (match.entity as NSString).length))
			} else {
				unescaped.append("&")
				target.deleteCharacters(in: NSRange(location: 0, length: 1))
			}
		}
		
		return unescaped as String
	}
	
	/** Returns a `NSString` that removes HTML elements. */
	@objc public var stringByRemovingHTML: String {
		
		var html = self as String
		let scanner = Scanner(string: html)
		
		while !scanner.isAtEnd {
			_ = scanner.scanUpToString("<")
			guard let text = scanner.scanUpToString(">") else { break }
			html = html.replacingOccurrences(of: "\(text)>", with: " ")
		}
		
		return html
	}
	
	/** Returns an MD5 string of from the given `NSString`. */
	@objc public var md5sum: String {
		Insecure.MD5
			.hash(data: Data((self as String).utf8))
			.map { String(format: "%02x", $0) }
			.joined()
	}
	
	/** Returns `YES` is a string has the substring, otherwise `NO`.
	@param substring The substring.
	@return `YES` if the substring is contained in the string, otherwise `NO`.
	*/
	@objc(hasString:)
	public func hasString(_ substring: String) -> Bool {
		range(of: substring).location != NSNotFound
	}
	
	/** Returns the length of the string minus the whitespace characters. */
	@objc public var lengthWithoutWhitespace: Int {
		(stringWithoutWhitespace as NSString).length
	}
	
	/** Returns a string without the whitespace characters. */
	@objc public var stringWithoutWhitespace: String {
		components(separatedBy: .whitespacesAndNewlines).joined()
	}
	
	/* Returns a string with the first word in each sentence as capitalized. */
	@objc public var capitalizeSentence: String {
		guard length > 0 else { return self as String }
		return replacingCharacters(in: NSRange(location: 0, length: 1),
		                           with: substring(to: 1).capitalized)
	}
	
	/** Returns the credit card type based on the first four digits of the card number.
	@return A credit card company name if the number matches a company otherwise nil.
	*/
	@objc public var creditCardType: String? {
		
		guard length >= 4 else { return nil }
		
		switch (substring(to: 2) as NSString).integerValue {
			case 34, 37:  return NSLocalizedString("American Express", comment: "")
			case 36:      return NSLocalizedString("Diners Club", comment: "")
			case 38:      return NSLocalizedString("Carte Blanche", comment: "")
			case 51...55: return NSLocalizedString("Master Card", comment: "")
			default: break
		}
		
		switch (substring(to: 4) as NSString).integerValue {
			case 2014, 2149: return NSLocalizedString("EnRoute", comment: "")
			case 2131, 1800: return NSLocalizedString("JCB", comment: "")
			case 6011:       return NSLocalizedString("Discover", comment: "")
			default: break
		}
		
		if case 300...305 = (substring(to: 3) as NSString).integerValue {
			return NSLocalizedString("Diners Club", comment: "")
		}
		
		switch (substring(to: 1) as NSString).integerValue {
			case 3: return NSLocalizedString("JCB", comment: "")
			case 4: return NSLocalizedString("Visa", comment: "")
			default: break
		}
		
		return NSLocalizedString("Unknown", comment: "")
	}
	
	/** Returns YES if the card number passes the Luhn algorithm. No spaces in the card number.
	@return Returns YES if the card is a valid credit card number, otherwise NO.
	*/
	@objc(isValidCreditCardNumber)
	public var isValidCreditCardNumber: Bool {
		
		guard rangeOfCharacter(from: CharacterSet.decimalDigits.inverted).location == NSNotFound else {
			return false
		}
		
		var checksum = 0
		
		for (offset, character) in (self as String).reversed().enumerated() {
			guard let digit = character.wholeNumberValue else { return false }
			// Every second digit from the right is doubled, and a two digit
			// result contributes each of its digits separately.
			let value = offset.isMultiple(of: 2) ? digit : digit * 2
			checksum += value > 9 ? (value / 10) + (value % 10) : value
		}
		
		return checksum % 10 == 0
	}
	
	/** Returns a formatted phone number. So it'd transform a string 18005555555 would be 1-800-555-5555.
	@param deleteLastChar Remove the last character from the string.
	@return Returns an `NSString` that transform a string of numbers into a string human readable phone number.
	*/
	@objc(formattedPhoneNumberWithLastCharacterRemoved:)
	public func formattedPhoneNumber(withLastCharacterRemoved deleteLastChar: Bool) -> String {
		formattedPhoneNumber(withLastCharacterRemoved: deleteLastChar, limit: 15)
	}
	
	/** Returns a formatted phone number, capping an over-long number at `limit` digits.
	@param deleteLastChar Remove the last character from the string.
	@param limit The most characters returned when the number is too long to format.
	*/
	@objc(formattedPhoneNumberWithLastCharacterRemoved:limit:)
	public func formattedPhoneNumber(withLastCharacterRemoved deleteLastChar: Bool, limit: Int) -> String {
		
		guard length > 0 else { return "" }
		
		var digits = (self as String).replacingOccurrences(of: "[\\s-\\(\\)]",
		                                                   with: "",
		                                                   options: [.regularExpression, .caseInsensitive])
		
		// should we delete the last digit?
		if deleteLastChar {
			guard !digits.isEmpty else { return "" }
			digits.removeLast()
		}
		
		// 123 456 7890
		// format the number.. if it's less then 7 digits.. then use this regex.
		let count = (digits as NSString).length
		let leadingOne = digits.hasPrefix("1")
		
		if (count > 11 && leadingOne) || (count > 10 && !leadingOne) {
			return (digits as NSString).substring(to: min(limit, count))
		}
		
		let occurrence: String, replacement: String
		
		if count < 5 && leadingOne {
			occurrence = "(\\d{1})(\\d+)"
			replacement = "$1 ($2)"
		} else if count < 8 && leadingOne {
			occurrence = "(\\d{1})(\\d{3})(\\d+)"
			replacement = "$1 ($2) $3"
		} else if count < 7 {
			occurrence = "(\\d{3})(\\d+)"
			replacement = "($1) $2"
		} else if count > 6 && leadingOne {
			occurrence = "(\\d{1})(\\d{3})(\\d{3})(\\d+)"
			replacement = "$1 ($2) $3-$4"
		} else {
			occurrence = "(\\d{3})(\\d{3})(\\d+)"
			replacement = "($1) $2-$3"
		}
		
		return digits.replacingOccurrences(of: occurrence,
		                                   with: replacement,
		                                   options: .regularExpression,
		                                   range: digits.startIndex ..< digits.endIndex)
	}
	
}
