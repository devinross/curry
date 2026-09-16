//
//  DataTests.swift
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

import XCTest
import curry


/// Exercises the `dataKeys` hook. It is declared on an NSObject extension in Swift,
/// and this subclass overriding it is what proves the override still dispatches.
@objc(SampleItem)
final class SampleItem: NSObject {
	
	@objc var identifier: NSNumber?
	@objc var name: String?
	@objc var position: String?
	@objc var email: String?
	@objc var phone: String?
	
	@objc var createdAt: Date?
	@objc var updatedAt: Date?
	@objc var deletedAt: Date?
	@objc var finishedAt: Date?
	
	@objc var parentItem: SampleItem?
	@objc var childItems: NSArray?
	
	override class var dataKeys: [String: Any] {
		[
			"identifier": "id",
			"name":       "name",
			"createdAt":  ["created_at", "yyyy-MM-dd'T'HH:mm:ss"],
			"updatedAt":  ["updated_at", "yyyy-MM-dd"],
			"deletedAt":  ["deleted_at", "yyyy-MM-dd"],
			"finishedAt": ["finished_at", "yyyy-MM-dd"],
			"parentItem": ["class": NSStringFromClass(SampleItem.self), "key": "parent"],
			"childItems": ["class": NSStringFromClass(SampleItem.self), "key": "children",
			               "structure": NSStringFromClass(NSArray.self)],
			"phone":      "phone",
		]
	}
	
}


final class DataTests: XCTestCase {
	
	private let sample: [AnyHashable: Any] = [
		"id":         8000,
		"created_at": "2012-03-12T18:45:00",
		"updated_at": "2013-04-15",
		"name":       "Bobby Sanderson",
		"position":   NSNull(),
		"phone":      "1-800-123-4567",
		"deletedAt":  "2012-03-12",
		"finishedAt": NSNull(),
		"children":   [["id": 5], ["id": 20]],
		"parent":     ["id": 5],
	]
	
	func testShouldProperlyImportData() {
		
		let item = SampleItem.createObject(sample) as? SampleItem
		XCTAssertNotNil(item)
		
		XCTAssertEqual(item?.name, sample["name"] as? String)
		XCTAssertEqual(item?.identifier, NSNumber(value: 8000))
		XCTAssertNotNil(item?.createdAt, "SampleItem createdAt should not be nil")
		XCTAssertNotNil(item?.updatedAt, "SampleItem updatedAt should not be nil")
		
		// These keys are absent or NSNull in the payload.
		XCTAssertNil(item?.position, "position is not nil")
		XCTAssertNil(item?.finishedAt, "finishedAt is not nil")
		XCTAssertNil(item?.deletedAt, "deletedAt is not nil")
		
		XCTAssertNotNil(item?.parentItem, "SampleItem 'parent' is not a SampleItem")
		XCTAssertEqual(item?.parentItem?.identifier, NSNumber(value: 5),
		               "SampleItem's parent doesn't have an id of 5.")
		
		XCTAssertNotNil(item?.childItems, "SampleItem 'childItems' is not an array")
		XCTAssertEqual((item?.childItems?.firstObject as? SampleItem)?.identifier, NSNumber(value: 5))
		XCTAssertEqual((item?.childItems?.lastObject as? SampleItem)?.identifier, NSNumber(value: 20))
	}
	
	func testShouldHandleImportingAClassStrucureWhenContentIsntADictionary() {
		var payload = sample
		payload["parent"] = [5, 4]
		payload["children"] = nil
		XCTAssertNotNil(SampleItem.createObject(payload), "Should not throw when parent isn't a dictionary")
	}
	
	func testShouldHandleImportingAClassArrayStrucureWhenArrayContentsIsntDictionaries() {
		var payload = sample
		payload["children"] = [5, 4]
		payload["parent"] = nil
		XCTAssertNotNil(SampleItem.createObject(payload), "Should not throw when children aren't dictionaries")
	}
	
	func testShouldHandleWhenDataIsNotADictionaryProperly() {
		XCTAssertNil(SampleItem.createObject(NSNull()), "NSNull should make no object")
		XCTAssertNotNil(SampleItem.createObject(nil), "nil should still make an object")
	}
	
	func testShouldHaveDataKeys() {
		XCTAssertTrue(NSObject.dataKeys.isEmpty)
		XCTAssertFalse(SampleItem.dataKeys.isEmpty)
	}
	
	func testShouldHandleCreatingADataDictionary() {
		
		let item = SampleItem.createObject(sample) as? SampleItem
		let output = item?.dataDictionary ?? [:]
		
		XCTAssertEqual(output["id"] as? NSNumber, NSNumber(value: 8000))
		XCTAssertEqual(output["created_at"] as? String, sample["created_at"] as? String)
		XCTAssertEqual(output["updated_at"] as? String, sample["updated_at"] as? String)
		XCTAssertEqual(output["phone"] as? String, sample["phone"] as? String)
	}
	
}
