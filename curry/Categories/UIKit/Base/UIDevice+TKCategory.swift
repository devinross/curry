//
//  UIDevice+TKCategory.swift
//  Created by Devin Ross on 9/13/16.
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

/// Additional functionality for `UIDevice`.
extension UIDevice {
	
	/// Returns `true` if the device is an iPad.
	public var padIdiom: Bool {
		return self.userInterfaceIdiom == .pad
	}
	
	/// Returns `true` if the device is an iPhone or iPod touch.
	public var phoneIdiom: Bool {
		return self.userInterfaceIdiom == .phone
	}
	
	/// Returns `true` if the device is a tvOS device
	public var tvIdiom: Bool {
		if #available(iOS 9.0, *) {
			return self.userInterfaceIdiom == .tv
		} else {
			return false
		}
	}
	
	/// Returns `true` if the device is a car play device
	public var carPlayIdiom: Bool {
		if #available(iOS 9.0, *) {
			return self.userInterfaceIdiom == .carPlay
		} else {
			return false
		}
	}

}
