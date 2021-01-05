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

import CoreLocation
import UIKit


/// Additional functionality for `UIApplication`.
extension UIApplication {
	
	
	private func PARAM(_ KEY : Any, _ VALUE : Any) -> String {
	 return "\(KEY)=\(VALUE)"
	}
	
    @objc public func canOpenUberApp() -> Bool {
        if let url = URL(string: "uber://") {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }

	/// Opens the Uber app with the given callbacks.
	/// - Parameters:
	///   - clientID: The clientID given by Uber to identify the app that launched the app.
	///   - productID: A specific product id for things like UberTaxi, UberRush.
	///   - pickupCoordinate: The latitude and longitude of the pickup.
	///   - pickupName: Pickup location name.
	///   - pickupAddress: The full address of the pickup location.
	///   - dropoff: The latitude and longitude of the dropoff.
	///   - dropoffName: The name of the location to dropoff.
	///   - dropoffAddress: The full address of the dropoff location.
	@objc public func openUberApp(withClient clientID: String?, product productID: String?, pickup: CLLocationCoordinate2D, pickupName: String?, pickupAddress: String?, dropoff: CLLocationCoordinate2D, dropoffName: String?, dropoffAddress: String?) {

        var array = ["action=setPickup"]

        if let clientID = clientID {
            array.append(PARAM("client_id", clientID))
        }
        if let productID = productID {
            array.append(PARAM("product_id", productID))
        }

        if pickup.latitude != 0 {
            array.append(PARAM("pickup[latitude]", NSNumber(value: pickup.latitude)))
            array.append(PARAM("pickup[longitude]", NSNumber(value: pickup.longitude)))
        }

        if let pickupAddress = pickupAddress {
            array.append(PARAM("pickup[formatted_address]", pickupAddress.urlEncode!))
        }
        if let pickupName = pickupName {
            array.append(PARAM("pickup[nickname]", pickupName.urlEncode!))
        }


        if dropoff.latitude != 0 {
            array.append(PARAM("dropoff[latitude]", NSNumber(value: dropoff.latitude)))
            array.append(PARAM("dropoff[longitude]", NSNumber(value: dropoff.longitude)))
        }

        if let dropoffAddress = dropoffAddress {
            array.append(PARAM("dropoff[formatted_address]", dropoffAddress.urlEncode!))
        }
        if dropoffName != nil {
			array.append(PARAM("dropoff[nickname]", dropoffName!.urlEncode!))
        }

        let url = "uber://?\(array.joined(separator: "&"))"
        if let url1 = URL(string: url) {
            open(url1, options: [:], completionHandler: { success in

            })
        }



    }

	/// Opens Google maps app (or URL) to the given coordinates and query.
	/// - Parameters:
	///   - coordinates: The coordinates to open to.
	///   - query: The search query.
	@objc public func openGoogleMapURL(withCoordinate coordinates: CLLocationCoordinate2D, query: String?) {

        var endpoint = "http://maps.google.com/maps?ll=%@&q=%@"

        if let url = URL(string: "comgooglemaps://?center=") {
            if canOpenURL(url) {
                endpoint = "comgooglemaps://?center=%@&q=%@"
            }
        }

        let latlong = "\(NSNumber(value: coordinates.latitude)),\(NSNumber(value: coordinates.longitude))".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

        let url = String(format: endpoint, latlong ?? "", query?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")

        if let url1 = URL(string: url) {
            open(url1, options: [:], completionHandler: { success in

            })
        }
    }

	/// Opens Apple maps app to the given coordinates and query.
	/// - Parameters:
	///   - coordinates: The coordinates to open to.
	///   - query: The search query.
	@objc public func openAppleMapURL(withCoordinate coordinates: CLLocationCoordinate2D, query: String?) {

        let endpoint = "http://maps.apple.com/maps?ll=%@&q=%@"

        let latlong = "\(NSNumber(value: coordinates.latitude)),\(NSNumber(value: coordinates.longitude))".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

        let url = String(format: endpoint, latlong ?? "", query?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")

        if let url1 = URL(string: url) {
            open(url1, options: [:], completionHandler: { success in

            })
        }

    }
}
