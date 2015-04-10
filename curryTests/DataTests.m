//
//  DataTests.m
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

#import "DataTests.h"
#import "NSObject+TKCategory.h"

@interface SampleItem : NSObject

@property (nonatomic,strong) NSNumber *identifier;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *email;

@property (nonatomic,strong) NSDate *createdAt;
@property (nonatomic,strong) NSDate *updatedAt;
@property (nonatomic,strong) NSDate *deletedAt;
@property (nonatomic,strong) NSDate *finishedAt;

@property (nonatomic,strong) SampleItem *parentItem;
@property (nonatomic,strong) NSArray *childItems;

@end


@implementation SampleItem

+ (NSDictionary*) dataKeys{
	return @{
	@"identifier"	: @"id",
	@"name"			: @"name",
	@"createdAt"	: @[@"created_at",@"yyyy-MM-dd'T'HH:mm:ss"],
	@"updatedAt"	: @[@"updated_at",@"yyyy-MM-dd"],
	@"deletedAt"	: @[@"deleted_at"],
	@"finishedAt"	: @[@"finished_at",@"yyyy-MM-dd"],
	@"parentItem"	: @{@"class": NSStringFromClass([SampleItem class]),		@"key": @"parent" },
	@"childItems"	: @{@"class": NSStringFromClass([SampleItem class]),		@"key": @"children", @"structure" :  NSStringFromClass([NSArray class]) },

	
	};
}

@end

@implementation DataTests

- (void) testShouldProperlyImportData{
	
	NSDictionary *dict = @{
	@"id"			: @8000,
	@"created_at"	: @"2012-03-12T18:45:00",
	@"updated_at"	: @"2013-04-15",
	@"name"			: @"Bobby Sanderson",
	@"position"		: [NSNull null],
	@"phone"		: @"1-800-123-4567",
	@"deletedAt"	: @"2012-03-12",
	@"finishedAt"	: [NSNull null],
	@"children"		: @[@{@"id": @5},@{@"id": @20}],
	@"parent"		: @{@"id": @5}

	};
	
	SampleItem *item = [SampleItem createObject:dict];
	
	XCTAssertEqualObjects(dict[@"name"], item.name, @"%@ isn't equal to %@",dict[@"name"],item.name);
	XCTAssertEqualObjects(dict[@"id"], item.identifier, @"%@ isn't equal to %@",dict[@"id"],item.identifier);
	XCTAssertNotNil(item.createdAt, @"SampleItem createdAt should not be nil");
	XCTAssertNotNil(item.updatedAt, @"SampleItem updatedAt should not be nil");
	
	

	
	XCTAssertNil(item.position, @"Finished at property is not nil");
	XCTAssertNil(item.finishedAt, @"Finished at property is not nil");
	XCTAssertNil(item.deletedAt, @"Finished at property is not nil");

	
	XCTAssertTrue([item.createdAt isKindOfClass:[NSDate class]], @"SampleItem 'createdAt' property is not a NSDate class.");
	XCTAssertTrue([item.updatedAt isKindOfClass:[NSDate class]], @"SampleItem 'updatedAt' property is not a NSDate class.");


	XCTAssertTrue([item.parentItem isKindOfClass:[SampleItem class]], @"SampleItem 'parent' property is not a SampleItem class.");

	XCTAssertTrue([item.parentItem.identifier isEqualToNumber:@5], @"SampleItem's parent doesn't have an id of 5.");

	
	XCTAssertTrue([item.childItems isKindOfClass:[NSArray class]], @"SampleItem 'childItems' property is not a NSArray class.");

	
	SampleItem *child1 = item.childItems.firstObject;
	SampleItem *child2 = item.childItems.lastObject;

	
	XCTAssertTrue([child1.identifier isEqualToNumber:@5], @"SampleItem's child doesn't have an id of 5.");
	XCTAssertTrue([child2.identifier isEqualToNumber:@20], @"SampleItem's child doesn't have an id of 5.");

}

- (void) testShouldHandleImportingAClassStrucureWhenContentIsntADictionary{
	
	NSDictionary *dict = @{@"id"			: @8000,
						   @"created_at"	: @"2012-03-12T18:45:00",
						   @"updated_at"	: @"2013-04-15",
						   @"name"			: @"Bobby Sanderson",
						   @"position"		: [NSNull null],
						   @"phone"			: @"1-800-123-4567",
						   @"deletedAt"		: @"2012-03-12",
						   @"finishedAt"	: [NSNull null],
						   @"parent"		: @[@5,@4] };
	
	XCTAssertNoThrow([SampleItem createObject:dict], @"We don't throw exception when ");
	
}

- (void) testShouldHandleImportingAClassArrayStrucureWhenArrayContentsIsntDictionaries{
	
	NSDictionary *dict = @{@"id"			: @8000,
						   @"created_at"	: @"2012-03-12T18:45:00",
						   @"updated_at"	: @"2013-04-15",
						   @"name"			: @"Bobby Sanderson",
						   @"position"		: [NSNull null],
						   @"phone"			: @"1-800-123-4567",
						   @"deletedAt"		: @"2012-03-12",
						   @"finishedAt"	: [NSNull null],
						   @"children"		: @[@5,@4] };
	
	XCTAssertNoThrow([SampleItem createObject:dict], @"We don't throw exception when ");
	
}

- (void) testShouldHandleWhenDataIsNotADictionaryProperly{
	SampleItem *item;

	item = [SampleItem createObject:(id)[NSNull null]];
	XCTAssertNil(item, @"Item is nil");
	
	item = [SampleItem createObject:nil];
	XCTAssertNotNil(item, @"Item is nil");
}

@end
