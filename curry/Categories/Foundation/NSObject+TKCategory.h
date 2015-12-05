//
//  NSObject+TKCategory.h
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

@import Foundation;

/** Additional functionality for `NSObject`.  */
@interface NSObject (TKCategory)

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
+ (NSDictionary*) dataKeys;


/** Creates object and imports data from an `NSDictionary` objects using the map provided by the dataKeys dictionary.
 
 @param dictionary The data that will be imported.
 @returns The newly allocated object.

 */
+ (id) createObject:(NSDictionary*)dictionary;


- (instancetype) initWithDataDictionary:(NSDictionary*)dictionary;


/** Imports data from an `NSDictionary` objects using the map provided by the dataKeys dictionary.
 
 @param dictionary The data that will be imported.
 */
- (void) importDataWithDictionary:(NSDictionary*)dictionary;


@property (nonatomic, readonly, copy) NSDictionary *dataDictionary;


@end
