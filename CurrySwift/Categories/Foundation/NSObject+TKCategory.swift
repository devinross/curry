//
//  NSObject+TKCategory.swift
//  Created by Devin Ross on 12/29/12.
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


/// Mirrors the `VALID_OBJECT` macro: non-nil, not `NSNull`, and not an empty string.
private func isValid(_ object: Any?) -> Bool {
	guard let object, !(object is NSNull) else { return false }
	if let string = object as? String { return !string.isEmpty }
	if let string = object as? NSString { return string.length > 0 }
	return true
}


/** Additional functionality for `NSObject`. */
extension NSObject {
	
	/** For subclassing, this method should return the item's properties mapped to the data dictionary keys.
	See the DataTests.m for an example implementation.
	
		@{
			@"identifier"		: @"id",
			@"name"				: @"name",
			@"createdAt"		: @[@"created_at",@"yyyy-MM-dd'T'HH:mm:ss"], // For NSDate
			@"updatedAt"		: @[@"updated_at",@"yyyy-MM-dd"],
			@"sub-objects"		: @{ @"class" : @"Product", @"structure" : @"NSArray", @"key" : @"products" }
		};
	
	@returns The dictionary used to fill up data from the data dictionary.
	*/
	@objc open class var dataKeys: [String: Any] { [:] }
	
	/** Creates object and imports data from a dictionary using the map provided by the dataKeys dictionary.
	@param dictionary The data that will be imported.
	@returns The newly allocated object.
	*/
	@objc(createObject:)
	open class func createObject(_ dictionary: Any?) -> Any? {
		// `NSNull` stands for "there was no object here", so there is none to make.
		if dictionary is NSNull { return nil }
		let object = self.init()
		object.importData(with: dictionary)
		return object
	}
	
	/** Creates an object and imports data from a dictionary using the dataKeys map.
	@param dictionary The data that will be imported.
	*/
	@objc(initWithDataDictionary:)
	public convenience init?(dataDictionary dictionary: Any?) {
		if dictionary is NSNull { return nil }
		self.init()
		importData(with: dictionary)
	}
	
	/** Imports data from a dictionary using the map provided by the dataKeys dictionary.
	@param dictionary The data that will be imported.
	*/
	@objc(importDataWithDictionary:)
	open func importData(with rawData: Any?) {
		
		guard let rawData = rawData as? [AnyHashable: Any] else { return }
		
		var formatter: DateFormatter?
		let propertyKeys = type(of: self).dataKeys
		
		for (propertyKey, jsonKey) in propertyKeys {
			
			// A plain key copies the value straight across.
			if let key = jsonKey as? String {
				
				let value = rawData[key]
				if isValid(value) { setValue(value, forKey: propertyKey) }
				
			// A [key, dateFormat] pair parses the value as a date.
			} else if let pair = jsonKey as? [Any], let key = pair.first as? String, let format = pair.last as? String {
				
				guard isValid(format), isValid(key), isValid(rawData[key]),
				      let text = rawData[key] as? String else { continue }
				
				if formatter == nil { formatter = DateFormatter() }
				formatter?.dateFormat = format
				setValue(formatter?.date(from: text), forKey: propertyKey)
				
			// A descriptor dictionary builds nested objects of a named class.
			} else if let descriptor = jsonKey as? [String: Any] {
				
				guard let key = descriptor["key"] as? String else { continue }
				
				let className = descriptor["class"] as? String ?? ""
				let objectClass = NSClassFromString(className) as? NSObject.Type
				let wantsArray = (descriptor["structure"] as? String).map { NSClassFromString($0) === NSArray.self } ?? false
				
				if wantsArray, let rawArray = rawData[key] as? [Any] {
					
					let objects = rawArray.compactMap { element -> Any? in
						guard let subDictionary = element as? [AnyHashable: Any] else { return nil }
						return objectClass?.createObject(subDictionary)
					}
					setValue(objects, forKey: propertyKey)
					
				} else if !wantsArray, let subDictionary = rawData[key] as? [AnyHashable: Any] {
					
					setValue(objectClass?.createObject(subDictionary), forKeyPath: propertyKey)
					
				} else if !(rawData[key] is [AnyHashable: Any]) && !(rawData[key] is [Any]) {
					
					setValue(nil, forKeyPath: propertyKey)
					
				}
			}
		}
	}
	
	/** The receiver's properties rendered back out through the dataKeys map. */
	@objc open var dataDictionary: [AnyHashable: Any] {
		
		var formatter: DateFormatter?
		var result: [AnyHashable: Any] = [:]
		let dataKeys = type(of: self).dataKeys
		
		for (propertyKey, jsonKey) in dataKeys {
			
			guard let value = self.value(forKey: propertyKey) else { continue }
			
			// Dates go back out through the format they were parsed with.
			if let date = value as? Date, let pair = jsonKey as? [Any], let key = pair.first as? AnyHashable {
				
				if formatter == nil { formatter = DateFormatter() }
				formatter?.dateFormat = pair.last as? String
				result[key] = formatter?.string(from: date)
				
			} else if let descriptor = jsonKey as? [String: Any], let key = descriptor["key"] as? AnyHashable {
				
				let wantsArray = (descriptor["structure"] as? String).map { NSClassFromString($0) === NSArray.self } ?? false
				
				if wantsArray {
					guard let objects = value as? [NSObject] else { continue }
					result[key] = objects.map { $0.dataDictionary }
				} else {
					result[key] = (value as? NSObject)?.dataDictionary
				}
				
			} else if let key = jsonKey as? AnyHashable {
				
				result[key] = value
				
			}
		}
		
		return result
	}
	
}
