//
//  UIApplication+TKCategory.m
//  Created by Devin Ross on 4/6/15.
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

#import "UIApplication+TKCategory.h"
#import "NSString+TKCategory.h"

#define PARAM(_KEY,_VALUE) [NSString stringWithFormat:@"%@=%@",_KEY,_VALUE]

@implementation UIApplication (TKCategory)


- (BOOL) canOpenUberApp{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"uber://"]];
}

- (void) openUberAppWithClient:(NSString*)clientID product:(NSString*)productID pickup:(CLLocationCoordinate2D)pickup pickupName:(NSString*)pickupName pickupAddress:(NSString*)pickupAddress dropoff:(CLLocationCoordinate2D)dropoff dropoffName:(NSString*)dropoffName dropoffAddress:(NSString*)dropoffAddress{
    
    NSMutableArray *array = @[@"action=setPickup"].mutableCopy;
    
    if(clientID) [array addObject:PARAM(@"client_id", clientID)];
    if(productID) [array addObject:PARAM(@"product_id", productID)];

    if(pickup.latitude != 0){
        [array addObject:PARAM(@"pickup[latitude]", @(pickup.latitude))];
        [array addObject:PARAM(@"pickup[longitude]", @(pickup.longitude))];
    }

    if(pickupAddress) [array addObject:PARAM(@"pickup[formatted_address]",pickupAddress.URLEncode)];
    if(pickupName) [array addObject:PARAM(@"pickup[nickname]",pickupName.URLEncode)];
    
    
    if(dropoff.latitude != 0){
        [array addObject:PARAM(@"dropoff[latitude]", @(dropoff.latitude))];
        [array addObject:PARAM(@"dropoff[longitude]", @(dropoff.longitude))];
    }

    if(dropoffAddress) [array addObject:PARAM(@"dropoff[formatted_address]",dropoffAddress.URLEncode)];
    if(dropoffAddress) [array addObject:PARAM(@"dropoff[nickname]",dropoffName.URLEncode)];
    
    NSString *url = [NSString stringWithFormat:@"uber://?%@",[array componentsJoinedByString:@"&"]];
    [self openURL:[NSURL URLWithString:url]];

    

}

- (void) openGoogleMapURLWithCoordinate:(CLLocationCoordinate2D)coordinates query:(NSString*)query{
    
    NSString *endpoint = @"http://maps.google.com/maps?ll=%@&q=%@";
    
    if([self canOpenURL:[NSURL URLWithString:@"comgooglemaps://?center="]])
        endpoint = @"comgooglemaps://?center=%@&q=%@";

    NSString *latlong = [[NSString stringWithFormat:@"%@,%@",@(coordinates.latitude),@(coordinates.longitude)] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *url = [NSString stringWithFormat:endpoint,latlong,[query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    [self openURL:[NSURL URLWithString:url]];
}

- (void) openAppleMapURLWithCoordinate:(CLLocationCoordinate2D)coordinates query:(NSString*)query{
    
    NSString *endpoint = @"http://maps.apple.com/maps?ll=%@&q=%@";
    
    NSString *latlong = [[NSString stringWithFormat:@"%@,%@",@(coordinates.latitude),@(coordinates.longitude)] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *url = [NSString stringWithFormat:endpoint,latlong,[query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    [self openURL:[NSURL URLWithString:url]];
    
}

@end
