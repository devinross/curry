//
//  UIApplication+TKCategory.swift
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

import UIKit
import CoreLocation


private func param(_ key: String, _ value: Any) -> String {
	"\(key)=\(value)"
}

private func urlQueryEncoded(_ text: String) -> String {
	text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
}


/** Additional functionality for `UIApplication`. */
extension UIApplication {
	
	/** Returns `true` if the app can open Uber. */
	@objc public var canOpenUberApp: Bool {
		guard let url = URL(string: "uber://") else { return false }
		return canOpenURL(url)
	}
	
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
	@objc(openUberAppWithClient:product:pickup:pickupName:pickupAddress:dropoff:dropoffName:dropoffAddress:)
	public func openUberApp(client clientID: String?,
	                        product productID: String?,
	                        pickup: CLLocationCoordinate2D,
	                        pickupName: String?,
	                        pickupAddress: String?,
	                        dropoff: CLLocationCoordinate2D,
	                        dropoffName: String?,
	                        dropoffAddress: String?) {
		
		var parameters = ["action=setPickup"]
		
		if let clientID { parameters.append(param("client_id", clientID)) }
		if let productID { parameters.append(param("product_id", productID)) }
		
		if pickup.latitude != 0 {
			parameters.append(param("pickup[latitude]", pickup.latitude))
			parameters.append(param("pickup[longitude]", pickup.longitude))
		}
		
		if let pickupAddress { parameters.append(param("pickup[formatted_address]", (pickupAddress as NSString).URLEncode)) }
		if let pickupName { parameters.append(param("pickup[nickname]", (pickupName as NSString).URLEncode)) }
		
		if dropoff.latitude != 0 {
			parameters.append(param("dropoff[latitude]", dropoff.latitude))
			parameters.append(param("dropoff[longitude]", dropoff.longitude))
		}
		
		if let dropoffAddress { parameters.append(param("dropoff[formatted_address]", (dropoffAddress as NSString).URLEncode)) }
		if let dropoffName { parameters.append(param("dropoff[nickname]", (dropoffName as NSString).URLEncode)) }
		
		open(urlString: "uber://?" + parameters.joined(separator: "&"))
	}
	
	/** Opens Google maps app (or URL) to the given coordinates and query.
	@param coordinates The coordinates to open to.
	@param query The search query.
	*/
	@objc(openGoogleMapURLWithCoordinate:query:)
	public func openGoogleMapURL(coordinate coordinates: CLLocationCoordinate2D, query: String) {
		
		var host = "http://maps.google.com/maps?ll="
		if let probe = URL(string: "comgooglemaps://?center="), canOpenURL(probe) {
			host = "comgooglemaps://?center="
		}
		
		open(urlString: host + mapQuery(coordinates, query))
	}
	
	/** Opens Apple maps app to the given coordinates and query.
	@param coordinates The coordinates to open to.
	@param query The search query.
	*/
	@objc(openAppleMapURLWithCoordinate:query:)
	public func openAppleMapURL(coordinate coordinates: CLLocationCoordinate2D, query: String) {
		open(urlString: "http://maps.apple.com/maps?ll=" + mapQuery(coordinates, query))
	}
	
	private func mapQuery(_ coordinates: CLLocationCoordinate2D, _ query: String) -> String {
		let latlong = urlQueryEncoded("\(coordinates.latitude),\(coordinates.longitude)")
		return "\(latlong)&q=\(urlQueryEncoded(query))"
	}
	
	private func open(urlString: String) {
		guard let url = URL(string: urlString) else { return }
		open(url, options: [:], completionHandler: nil)
	}
	
}
