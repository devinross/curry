//
//  TKSafariWebCredentials.swift
//  Created by Devin Ross on 5/6/17.
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

import Foundation
import Security


#if os(iOS)

/** Reads and writes the shared web credentials Safari keeps for a site.

- Warning: `SecRequestSharedWebCredential` and `SecAddSharedWebCredential` were
  deprecated in iOS 14. Apple's replacement is `ASAuthorizationController` with
  an `ASAuthorizationPasswordRequest`, from the AuthenticationServices framework.
*/
@objc(TKSafariWebCredentials)
open class TKSafariWebCredentials: NSObject {
	
	@available(iOS, deprecated: 14.0, message: "Use ASAuthorizationPasswordRequest instead.")
	@objc(getSafariCredentialsWithURL:failure:success:)
	public static func getSafariCredentials(url: URL,
	                                        failure: (@Sendable (Error?) -> Void)?,
	                                        success: (@Sendable (String?, String?) -> Void)?) {
		
		SecRequestSharedWebCredential(url.host as CFString?, nil) { credentials, error in
			
			if let error {
				DispatchQueue.main.async { failure?(error as Error) }
				return
			}
			
			// There will only ever be one credential dictionary.
			guard let credentials, CFArrayGetCount(credentials) > 0 else {
				DispatchQueue.main.async { failure?(nil) }
				return
			}
			
			let raw = CFArrayGetValueAtIndex(credentials, 0)
			let credential = unsafeBitCast(raw, to: CFDictionary.self) as NSDictionary
			
			let userName = credential[kSecAttrAccount as String] as? String
			let password = credential[kSecSharedPassword as String] as? String
			
			DispatchQueue.main.async { success?(userName, password) }
		}
	}
	
	@available(iOS, deprecated: 14.0, message: "Use ASAuthorizationPasswordRequest instead.")
	@objc(updateSafariCredentialsWithURL:email:password:failure:success:)
	public static func updateSafariCredentials(url: URL,
	                                           email: String,
	                                           password: String,
	                                           failure: (@Sendable (Error?) -> Void)?,
	                                           success: (@Sendable () -> Void)?) {
		
		SecAddSharedWebCredential(url.host as CFString? ?? "" as CFString, email as CFString, password as CFString) { error in
			
			if let error {
				DispatchQueue.main.async { failure?(error as Error) }
				return
			}
			
			DispatchQueue.main.async { success?() }
		}
	}
	
	@objc public static func generateSafariPassword() -> String? {
		SecCreateSharedWebCredentialPassword() as String?
	}
	
}

#endif
