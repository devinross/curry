//
//  PDFGeneratorViewController.h
//  Examples
//
//  Created by Devin Ross on 9/25/15.
//  Copyright © 2015 Devin Ross. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MessageUI;

@interface PDFGeneratorViewController : UIViewController

@property (nonatomic,strong) UIWebView *webView;

@end



@interface UIPrintPageRenderer (PDF)
- (NSData*) printToPDF;
@end


@interface UIWebView (PDF)

- (NSData*) generatePDFData;

@end