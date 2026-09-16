//
//  UITraitCollection+TKCategory.swift
//  Created by Devin Ross on 9/14/15.
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


extension UITraitCollection {
	
	@objc open var phoneUserInterfaceIdiom: Bool { userInterfaceIdiom == .phone }
	@objc open var padUserInterfaceIdiom: Bool { userInterfaceIdiom == .pad }
	
	@objc open var compactHorizontalSizeClass: Bool { horizontalSizeClass == .compact }
	@objc open var compactVerticalSizeClass: Bool { verticalSizeClass == .compact }
	@objc open var regularVerticalSizeClass: Bool { verticalSizeClass == .regular }
	@objc open var regularHorizontalSizeClass: Bool { horizontalSizeClass == .regular }
	
}
