//
//  PDFGeneratorViewController.m
//  Examples
//
//  Created by Devin Ross on 9/25/15.
//  Copyright © 2015 Devin Ross. All rights reserved.
//

#import "PDFGeneratorViewController.h"

@interface PDFGeneratorViewController () <UIWebViewDelegate,MFMailComposeViewControllerDelegate>

@end

@implementation PDFGeneratorViewController

#define kPaperSizeA4 CGSizeMake(595.2,841.8)

- (void) loadView{
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
	
	
	CGRect rr = CGRectZero;
	rr.size = kPaperSizeA4;
	self.webView = [[UIWebView alloc] initWithFrame:rr];
	//[self.view addSubview:self.webView];
	self.webView.delegate = self;
	
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.alto.co/invoices/jam_ny_llc/TGVNRVhnOVdqQTE5MzM0NTc3OTEwMjAxNA=="]]];
	
}

- (void) webViewDidFinishLoad:(UIWebView *)awebView{
	if (awebView.isLoading) return;
	
	
	//[self createPDFfromUIView:self.webView saveToDocumentsWithFileName:@"HELLO"];
	
	MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
	vc.mailComposeDelegate = self;
	NSData *data = [self createPDFfromUIView:self.webView];
	[vc addAttachmentData:data mimeType:@"application/pdf" fileName:@"PDF"];
	[self presentViewController:vc animated:YES completion:nil];
	
	
	
//	UIPrintPageRenderer *render = [[UIPrintPageRenderer alloc] init];
//	[render addPrintFormatter:awebView.viewPrintFormatter startingAtPageAtIndex:0];
//	//increase these values according to your requirement
//	float topPadding = 10.0f, bottomPadding = 10.0f;
//	float leftPadding = 10.0f, rightPadding = 10.0f;
//	CGRect printableRect = CGRectMake(leftPadding,
//									  topPadding,
//									  kPaperSizeA4.width-leftPadding-rightPadding,
//									  kPaperSizeA4.height-topPadding-bottomPadding);
//	CGRect paperRect = CGRectMake(0, 0, kPaperSizeA4.width, kPaperSizeA4.height);
//	[render setValue:[NSValue valueWithCGRect:paperRect] forKey:@"paperRect"];
//	[render setValue:[NSValue valueWithCGRect:printableRect] forKey:@"printableRect"];
//	NSData *pdfData = [render printToPDF];
//	if (pdfData) {
//		[pdfData writeToFile:[NSString stringWithFormat:@"%@/tmp.pdf",NSTemporaryDirectory()] atomically: YES];
//	}else{
//		NSLog(@"PDF couldnot be created");
//	}
}



- (NSData*) createPDFfromUIView:(UIView*)aView{
	// Creates a mutable data object for updating with binary data, like a byte array
	UIWebView *webView = (UIWebView*)self.webView;
	NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
	
	NSInteger height = [heightStr intValue];
	CGFloat screenHeight = webView.bounds.size.height;
	NSInteger pages = ceil(height / screenHeight);
	
	NSMutableData *pdfData = [NSMutableData data];
	UIGraphicsBeginPDFContextToData(pdfData, webView.bounds, nil);
	for(NSInteger i = 0; i < pages; i++) {
		// Check to screenHeight if page draws more than the height of the UIWebView
		if ((i+1) * screenHeight  > height) {
			CGRect f = webView.frame;
			f.size.height -= (((i+1) * screenHeight) - height);
			webView.frame = f;
		}
		
		UIGraphicsBeginPDFPage();
		CGContextRef currentContext = UIGraphicsGetCurrentContext();
		CGContextTranslateCTM(currentContext, 72, 72); // Translate for 1" margins
		
		[[webView.subviews lastObject] setContentOffset:CGPointMake(0, screenHeight * i) animated:NO];
		[webView.layer renderInContext:currentContext];
	}
	
	UIGraphicsEndPDFContext();


	return pdfData;
	
	
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
	[controller dismissViewControllerAnimated:YES completion:nil];
}


@end

@implementation UIWebView (PDF)

- (NSData*) generatePDFData{
	// Creates a mutable data object for updating with binary data, like a byte array
	NSString *heightStr = [self stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
	
	NSInteger height = [heightStr intValue];
	CGFloat screenHeight = self.bounds.size.height;
	NSInteger pages = ceil(height / screenHeight);
	
	NSMutableData *pdfData = [NSMutableData data];
	UIGraphicsBeginPDFContextToData(pdfData, self.bounds, nil);
	for(NSInteger i = 0; i < pages; i++) {
		// Check to screenHeight if page draws more than the height of the UIWebView
		if((i+1) * screenHeight  > height) {
			CGRect f = self.frame;
			f.size.height -= (((i+1) * screenHeight) - height);
			self.frame = f;
		}
		
		UIGraphicsBeginPDFPage();
		CGContextRef currentContext = UIGraphicsGetCurrentContext();
		//CGContextTranslateCTM(currentContext, 72, 72); // Translate for 1" margins
		
		[[self.subviews lastObject] setContentOffset:CGPointMake(0, screenHeight * i) animated:NO];
		[self.layer renderInContext:currentContext];
	}
	
	UIGraphicsEndPDFContext();
	
	
	return pdfData;
}

@end


@implementation UIPrintPageRenderer (PDF)

- (NSData*) printToPDF{
	NSMutableData *pdfData = [NSMutableData data];
	UIGraphicsBeginPDFContextToData( pdfData, self.paperRect, nil );
	[self prepareForDrawingPages: NSMakeRange(0, self.numberOfPages)];
	CGRect bounds = UIGraphicsGetPDFContextBounds();
	for ( int i = 0 ; i < self.numberOfPages ; i++ )
	{
		UIGraphicsBeginPDFPage();
		[self drawPageAtIndex: i inRect: bounds];
	}
	UIGraphicsEndPDFContext();
	return pdfData;
}
@end