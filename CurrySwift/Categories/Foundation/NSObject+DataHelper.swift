//
//  NSObject+DataHelper.swift
//  Created by Devin Ross on 1/31/14.
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


extension NSObject {
	
	/** Builds an array of objects from an array of data dictionaries. */
	@objc(arrayOfObjectsWithDataArray:)
	public static func arrayOfObjects(withDataArray array: [Any]) -> [Any] {
		array.compactMap { element in
			guard !(element is NSNull) else { return nil }
			return createObject(element)
		}
	}
	
	/** Builds an array of data dictionaries from an array of objects. */
	@objc(arrayOfDataObjectsWithObjectsArray:)
	public static func arrayOfDataObjects(withObjectsArray array: [Any]) -> [Any] {
		array.compactMap { ($0 as? NSObject)?.dataDictionary }
	}
	
}


extension NSArray {
	
	/** Groups the array's objects into a dictionary keyed by the given property.
	@param key The key path read from each object.
	*/
	@objc(groupByKey:)
	public func groupBy(key: String) -> [AnyHashable: Any] {
		var grouped: [AnyHashable: Any] = [:]
		for object in self {
			guard let keyValue = (object as AnyObject).value(forKey: key) as? AnyHashable else { continue }
			grouped[keyValue] = object
		}
		return grouped
	}
	
}
