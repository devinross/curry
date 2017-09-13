//
//  UIFont+TKCategory.m
//  Created by Devin Ross on 10/5/13.
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

#import "UIFont+TKCategory.h"

@implementation UIFont (TKCategory)

#pragma mark Helvetica Neue
+ (UIFont*) helveticaNeueWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue" size:size];
}
+ (UIFont*) helveticaNeueBoldItalicWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:size];
}
+ (UIFont*) helveticaNeueLightWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}
+ (UIFont*) helveticaNeueItalicWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-Italic" size:size];
}
+ (UIFont*) helveticaNeueUltraLightItalicWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-UltraLightItalic" size:size];
}
+ (UIFont*) helveticaNeueCondensedBoldWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:size];
}
+ (UIFont*) helveticaNeueMediumItalicWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-MediumItalic" size:size];
}
+ (UIFont*) helveticaNeueMediumWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}
+ (UIFont*) helveticaNeueThinItalicWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-Thin_Italic" size:size];
}
+ (UIFont*) helveticaNeueThinWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-Thin" size:size];
}
+ (UIFont*) helveticaNeueLightItalicWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:size];
}
+ (UIFont*) helveticaNeueUltraLightWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:size];
}
+ (UIFont*) helveticaNeueBoldWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}
+ (UIFont*) helveticaNeueCondensedBlackWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:size];
}


#pragma mark Avenir
+ (UIFont*) avenirHeavyWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-Heavy" size:size];
}
+ (UIFont*) avenirObliqueWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-Oblique" size:size];
}
+ (UIFont*) avenirBlackWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-Black" size:size];
}
+ (UIFont*) avenirBookWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-Book" size:size];
}
+ (UIFont*) avenirBlackObliqueWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-BlackOblique" size:size];
}
+ (UIFont*) avenirHeavyObliqueWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-HeavyOblique" size:size];
}
+ (UIFont*) avenirLightWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-Light" size:size];
}
+ (UIFont*) avenirMediumObliqueWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-MediumOblique" size:size];
}
+ (UIFont*) avenirMediumWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-Medium" size:size];
}
+ (UIFont*) avenirLightObliqueWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-LightOblique" size:size];
}
+ (UIFont*) avenirRomanWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-Roman" size:size];
}
+ (UIFont*) avenirBookObliqueWithSize:(CGFloat)size{
	return [UIFont fontWithName:@"Avenir-BookOblique" size:size];
}


#define EQL(_CAT,_TYPE) [_CAT isEqualToString:_TYPE]

+ (CGFloat) pointSizeWithXS:(CGFloat)xs s:(CGFloat)s m:(CGFloat)m l:(CGFloat)l xl:(CGFloat)xl xxl:(CGFloat)xxl xxxl:(CGFloat)xxxl{
	
	UIContentSizeCategory cat = [UIApplication sharedApplication].preferredContentSizeCategory;
	CGFloat fontSize = m;
	

	
	if(EQL(cat,UIContentSizeCategoryAccessibilityMedium)){
		fontSize = m;
	}else if([cat isEqualToString:UIContentSizeCategoryAccessibilityLarge] || [cat isEqualToString:UIContentSizeCategoryLarge]){
		fontSize = l;
	}else if([cat isEqualToString:UIContentSizeCategoryAccessibilityExtraLarge] || [cat isEqualToString:UIContentSizeCategoryExtraLarge]){
		fontSize = xl;
	}else if([cat isEqualToString:UIContentSizeCategoryExtraExtraLarge]){
		fontSize = xxl;
	}else if([cat isEqualToString:UIContentSizeCategoryExtraExtraExtraLarge]){
		fontSize = xxxl;
	}else if([cat isEqualToString:UIContentSizeCategorySmall]){
		fontSize = s;
	}else if([cat isEqualToString:UIContentSizeCategoryExtraSmall]){
		fontSize = xs;
	}

	return fontSize;
}



+ (CGFloat) pointSizeWithMedium:(CGFloat)m scaleFactor:(CGFloat)scale{
	
	UIContentSizeCategory cat = [UIApplication sharedApplication].preferredContentSizeCategory;
	CGFloat fontSize = m;
	CGFloat delta = m * scale - m;
	
	if( EQL(cat,UIContentSizeCategoryMedium) ){
		fontSize = m;
	}
	
	else if( EQL(cat,UIContentSizeCategoryLarge) ){
		fontSize = m + delta;
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraLarge) ){
		fontSize = m + delta * 2;
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraExtraLarge) ){
		fontSize = m + delta * 3;
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraExtraExtraLarge) ){
		fontSize = m + delta * 4;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityMedium) ){
		fontSize = m + delta * 5;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityLarge) ){
		fontSize = m + delta * 6;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityExtraLarge) ){
		fontSize = m + delta * 7;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityExtraExtraLarge) ){
		fontSize = m + delta * 8;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityExtraExtraExtraLarge) ){
		fontSize = m + delta * 9;
	}
	
	else if( EQL(cat,UIContentSizeCategorySmall) ){
		fontSize = m - delta;
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraSmall) ){
		fontSize = m - (delta * 2);
	}
	
	return fontSize;
}


+ (CGFloat) pointSizeWithLarge:(CGFloat)l scaleFactor:(CGFloat)scale{
	
	UIContentSizeCategory cat = [UIApplication sharedApplication].preferredContentSizeCategory;
	CGFloat fontSize = l;
	
	CGFloat delta = l * scale - l;
	
	
	if( EQL(cat,UIContentSizeCategoryMedium) ){
		fontSize = l - delta;
	}
	
	else if( EQL(cat,UIContentSizeCategoryLarge) ){
		fontSize = l;
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraLarge) ){
		fontSize = l + delta;
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraExtraLarge) ){
		fontSize = l + delta * 2;
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraExtraExtraLarge) ){
		fontSize = l + delta * 3;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityMedium) ){
		fontSize = l + delta * 4;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityLarge) ){
		fontSize = l + delta * 4;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityExtraLarge) ){
		fontSize = l + delta * 5;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityExtraExtraLarge) ){
		fontSize = l + delta * 6;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityExtraExtraExtraLarge) ){
		fontSize = l + delta * 7;
	}
	
	else if( EQL(cat,UIContentSizeCategorySmall) ){
		fontSize = delta - (delta * 2);
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraSmall) ){
		fontSize = l - (delta * 3);
	}
	
	return fontSize;
}

+ (CGFloat) pointSizeWithLarge:(CGFloat)l upScaleFactor:(CGFloat)upScale downScaleFactor:(CGFloat)downScale{
	
	UIContentSizeCategory cat = [UIApplication sharedApplication].preferredContentSizeCategory;
	CGFloat fontSize = l;
	
	
	CGFloat delta = l * upScale - l;
	CGFloat downDelta = l * downScale - l;
	
	
	if( EQL(cat,UIContentSizeCategoryMedium) ){
		fontSize = l - downDelta;
	}
	
	else if( EQL(cat,UIContentSizeCategoryLarge) ){
		fontSize = l;
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraLarge) ){
		fontSize = l + delta;
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraExtraLarge) ){
		fontSize = l + delta * 2;
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraExtraExtraLarge) ){
		fontSize = l + delta * 3;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityMedium) ){
		fontSize = l + delta * 4;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityLarge) ){
		fontSize = l + delta * 4;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityExtraLarge) ){
		fontSize = l + delta * 5;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityExtraExtraLarge) ){
		fontSize = l + delta * 6;
	}
	
	else if( EQL(cat,UIContentSizeCategoryAccessibilityExtraExtraExtraLarge) ){
		fontSize = l + delta * 7;
	}
	
	else if( EQL(cat,UIContentSizeCategorySmall) ){
		fontSize = delta - (downDelta * 2);
	}
	
	else if( EQL(cat,UIContentSizeCategoryExtraSmall) ){
		fontSize = l - (downDelta * 3);
	}
	
	
	return fontSize;
}


@end
