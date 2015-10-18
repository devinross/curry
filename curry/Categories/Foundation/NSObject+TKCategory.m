//
//  NSObject+TKCategory.m
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

#import "NSObject+TKCategory.h"

#define VALID_OBJECT(_OBJ) _OBJ &&	(id)_OBJ != [NSNull null] && ((![_OBJ isKindOfClass:[NSString class]]) || [(NSString*)_OBJ length] > 0)

@implementation NSObject (TKCategory)


+ (NSDictionary*) dataKeys{
	return @{};
}


+ (id) createObject:(NSDictionary*)data{
	return [[[self class] alloc] initWithDataDictionary:data];
}
- (instancetype) initWithDataDictionary:(NSDictionary*)dictionary{
	if((id)dictionary == [NSNull null]) return nil;
	if(!(self=[self init])) return nil;
	[self importDataWithDictionary:VALID_OBJECT(dictionary)?dictionary:nil];
	return self;
}
- (void) importDataWithDictionary:(NSDictionary*)rawData{
	if(![rawData isKindOfClass:[NSDictionary class]]) return;
	
	NSDateFormatter *formatter = nil;
	NSDictionary *propertyKeys = [[self class] dataKeys];
	
	for(NSString *propertyKey in propertyKeys.allKeys){
		
		id jsonKey = propertyKeys[propertyKey];
		
		if([jsonKey isKindOfClass:[NSString class]]){
			
			id obj = rawData[jsonKey];
			if(VALID_OBJECT(obj)) [self setValue:obj forKey:propertyKey];
			
		}else if([jsonKey isKindOfClass:[NSArray class]]){
			
			NSString *format = [jsonKey lastObject];
			jsonKey = [jsonKey firstObject];
			
			if(VALID_OBJECT(format) && VALID_OBJECT(jsonKey) && VALID_OBJECT(rawData[jsonKey])){
				if(!formatter) formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:format];
				NSDate *date = [formatter dateFromString:rawData[jsonKey]];
				[self setValue:date forKey:propertyKey];
			}
			
		}else if([jsonKey isKindOfClass:[NSDictionary class]]){

			NSDictionary *dataKeyDictionary = (NSDictionary*)jsonKey;
			Class class = NSClassFromString(dataKeyDictionary[@"class"]);
			jsonKey = dataKeyDictionary[@"key"];
			
			if([rawData[jsonKey] isKindOfClass:[NSDictionary class]] || [rawData[jsonKey] isKindOfClass:[NSArray class]]){
				Class structure = NSClassFromString(dataKeyDictionary[@"structure"]);
				if(structure == [NSArray class]){
					if([rawData[jsonKey] isKindOfClass:[NSArray class]]){
						NSArray *rawArray = rawData[jsonKey];
						NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:rawArray.count];
						for(NSDictionary *subDictionary in rawArray){
							
							
							if([subDictionary isKindOfClass:[NSDictionary class]])
								[mutableArray addObject:[class createObject:subDictionary]];

						}
						[self setValue:mutableArray.copy forKey:propertyKey];
					}
				}else if([rawData[jsonKey] isKindOfClass:[NSDictionary class]]){
					id obj = [class createObject:rawData[jsonKey]];
					[self setValue:obj forKeyPath:propertyKey];
				}
			}else{
				[self setValue:nil forKeyPath:propertyKey];
			}
		}
	}
	
}


- (NSDictionary*) dataDictionary{
	
	NSDateFormatter *formatter = nil;
	NSMutableDictionary *ret = [NSMutableDictionary dictionary];
	NSDictionary *dataKeys = [[self class] dataKeys];
	
	for(id propertyKey in [dataKeys allKeys]){
		
		id value = [self valueForKey:propertyKey];
		
		if(value && [value isKindOfClass:[NSDate class]]){
			NSArray *array = dataKeys[propertyKey];
			
			if(!formatter) formatter = [[NSDateFormatter alloc] init];
			formatter.dateFormat = array.lastObject;
			NSString *date = [formatter stringFromDate:value];
			ret[array[0]] = date;
			
		}else if(value && [dataKeys[propertyKey] isKindOfClass:[NSDictionary class]]){
			
			NSDictionary *keyDict = dataKeys[propertyKey];
			
			if(NSClassFromString(keyDict[@"structure"]) == [NSArray class]){
				
				NSArray *propertyArray = value;
				if(!propertyArray) continue;
				
				NSMutableArray *dictArray = [NSMutableArray arrayWithCapacity:propertyArray.count];
				for(id obj in propertyArray){
					[dictArray addObject:[obj dataDictionary]];
				}
				ret[dataKeys[propertyKey][@"key"]] = dictArray.copy;

			}else{
				ret[dataKeys[propertyKey][@"key"]] = [value dataDictionary];
			}
			
			
		}else if(value)
			ret[dataKeys[propertyKey]] = value;
		
	}
	return ret;
	
}







@end
