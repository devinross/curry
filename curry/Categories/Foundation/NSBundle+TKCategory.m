//
//  NSBundle+TKCategory.m
//  curry
//
//  Created by Devin Ross on 4/10/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "NSBundle+TKCategory.h"

@implementation NSBundle (TKCategory)


- (NSString*) appName{
    return self.infoDictionary[@"CFBundleDisplayName"];
}
- (NSString*) version{
    return self.infoDictionary[@"CFBundleShortVersionString"];
}
- (NSString*) build{
    return self.infoDictionary[@"CFBundleVersion"];
}



@end
