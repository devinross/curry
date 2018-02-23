//
//  VelocityViewController.m
//  Created by Devin Ross on 2/22/18.
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

#import "VelocityViewController.h"

@interface VelocityViewController ()
@property (nonatomic,assign) CGPoint p;
@end

@implementation VelocityViewController

- (void) viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	
	CGFloat cubeWidth = 90, inset = 100, dot = 10;
	CGRect rect;
	UIView *peg1, *peg2, *peg3;
	
	rect = CGRectCenteredXInRect(self.view.bounds, inset + cubeWidth/2, dot, dot);
	peg1 = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithWhite:0.9 alpha:1] cornerRadius:dot / 2];
	[self.view addSubview:peg1];
	
	rect = CGRectCenteredInRect(self.view.bounds, dot, dot);
	peg2 = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithWhite:0.9 alpha:1] cornerRadius:dot / 2];
	[self.view addSubview:peg2];
	
	rect = CGRectCenteredXInRect(self.view.bounds, self.view.height  - inset - cubeWidth/2 - dot/2, dot, dot);
	peg3 = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithWhite:0.9 alpha:1] cornerRadius:dot / 2];
	[self.view addSubview:peg3];
	
	rect = CGRectCenteredXInRect(self.view.bounds, inset, cubeWidth, cubeWidth);
	self.block = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithHex:0xf9b307] cornerRadius:8];
	[self.view addSubview:self.block];
	
	self.pegs = @[peg1,peg2,peg3];
	
	
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
	[self.block addGestureRecognizer:pan];

}

- (void) pan:(UIPanGestureRecognizer*)gesture{
	CGPoint velocity = [gesture velocityInView:self.view];
	CGPoint trans = [gesture translationInView:self.view];

	if(gesture.began){
		
		self.p = self.block.center;
		
	}else if(gesture.changed){
		
		CGPoint p = trans;
		p.x = self.p.x;
		p.y += self.p.y;
		self.block.center = p;
		
	}else if(gesture.ended){
		
		
		CGPoint p = trans;
		p.x += self.p.x;
		p.y += self.p.y;
		
		CGFloat damp = 10;
		CGFloat projectedX = p.x + velocity.x / damp;
		CGFloat projectedY = p.y + velocity.y / damp;
		CGPoint projectedPoint = CGPointMake(projectedX, projectedY);

		UIView *landing = self.pegs.firstObject;
		NSInteger i = 1;
		CGFloat dis = CGPointGetDistance(landing.center, projectedPoint);
		for(UIView *peg in self.pegs){
			CGFloat pDistance = CGPointGetDistance(peg.center, projectedPoint);
			if(pDistance < dis){
				landing = peg;
				dis = pDistance;
			}
			i++;
		}
		
		[UIView animateWithDuration:1 dampingRatio:0.6 initialVelocity:CGVectorMake(velocity.x, velocity.y) animations:^{
			self.block.center = landing.center;
		} completion:nil];
		
	}
}




@end
