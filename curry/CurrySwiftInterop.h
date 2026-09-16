//
//  CurrySwiftInterop.h
//  Created by Devin Ross on 9/16/26.
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

#ifndef curry_CurrySwiftInterop_h
#define curry_CurrySwiftInterop_h

// Reaches the half of curry that now lives in Swift.
//
// Under Swift Package Manager the Swift code is its own module, because a
// SwiftPM target cannot mix Swift and Objective-C. In the Xcode framework
// targets it shares a module with this file, so it arrives through that
// target's generated -Swift.h instead. The framework targets each have their
// own module name, hence the search below.

#if SWIFT_PACKAGE

// SwiftPM cannot mix Swift and Objective-C in one target, so the Swift half is
// its own module.
@import CurrySwift;

#else

// The Xcode framework targets compile Swift alongside this file, so it arrives
// through the generated interface header. Every target emits it under the same
// name (SWIFT_OBJC_INTERFACE_HEADER_NAME) but inside its own framework.
#if __has_include(<curry/curry-Swift.h>)
#import <curry/curry-Swift.h>
#elif __has_include(<curryTV/curry-Swift.h>)
#import <curryTV/curry-Swift.h>
#elif __has_include(<curryMac/curry-Swift.h>)
#import <curryMac/curry-Swift.h>
#elif __has_include(<curryWatch/curry-Swift.h>)
#import <curryWatch/curry-Swift.h>
#else
#error "curry: generated Swift interface header not found. Check SWIFT_OBJC_INTERFACE_HEADER_NAME."
#endif

#endif

#endif
