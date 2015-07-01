//
//  UIApplication+TKCategory.h
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

@import UIKit;
@import CoreLocation;

/** Additional functionality for `UIApplication`. */
@interface UIApplication (TKCategory)

/** Opens Google maps app (or URL) to the given coordinates and query.
 @param coordinates The coordinates to open to.
 @param query The search query.
 */
- (void) openGoogleMapURLWithCoordinate:(CLLocationCoordinate2D)coordinates query:(NSString*)query;

/** Opens Apple maps app to the given coordinates and query.
 @param coordinates The coordinates to open to.
 @param query The search query.
 */
- (void) openAppleMapURLWithCoordinate:(CLLocationCoordinate2D)coordinates query:(NSString*)query;


/** Returns `true` if the app can open Uber. */
@property (nonatomic, readonly) BOOL canOpenUberApp;


/** Opens the Uber app with the given callbacks.
 @param clientID The clientID given by Uber to identify the app that launched the app.
 @param productID A specific product id for things like UberTaxi, UberRush.
 @param pickupCoordinate The latitude and longitude of the pickup.
 @param pickupName Pickup location name.
 @param pickupAddress The full address of the pickup location.
 @param dropoff The latitude and longitude of the dropoff.
 @param dropoffName The name of the location to dropoff.
 @param dropoffAddress The full address of the dropoff location.
 */
- (void) openUberAppWithClient:(NSString*)clientID
					   product:(NSString*)productID
						pickup:(CLLocationCoordinate2D)pickupCoordinate
					pickupName:(NSString*)pickupName
				 pickupAddress:(NSString*)pickupAddress
					   dropoff:(CLLocationCoordinate2D)dropoff
				   dropoffName:(NSString*)dropoffName
				dropoffAddress:(NSString*)dropoffAddress;

@end
