//
//  TKShapeView.h
//  Created by Devin Ross on 6/24/12.
//
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
@import QuartzCore;

/** This class implements `UIView` backed by a `CAShapeLayer`. */
@interface TKShapeView : UIView

/** The path defining the shape of the view. */
@property CGPathRef path;

/** The CAShapeLayer object. */
@property (nonatomic,readonly) CAShapeLayer *shapeLayer;

/** The stroke color */
@property (nonatomic,strong) UIColor *strokeColor;

/** The stoke's line width. */
@property (nonatomic,assign) CGFloat lineWidth;

/** The fill color. */
@property (nonatomic,strong) UIColor *fillColor;

@end
