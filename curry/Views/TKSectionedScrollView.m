//
//  TKSectionedScrollView.m
//  Created by Devin Ross on 4/8/15.
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

#import "TKSectionedScrollView.h"
#import "TKFoundation.h"
#import "TKUIKit.h"
#import "TKUIKit.h"

@interface TKSectionedScrollView ()

@property (nonatomic,assign) CGFloat canMoveRight;
@property (nonatomic,assign) CGFloat canMoveLeft;
@property (nonatomic,assign) BOOL movingPages;

@end

@implementation TKSectionedScrollView


- (instancetype) initWithFrame:(CGRect)frame numberOfSections:(NSUInteger)sections{
    if(!(self=[super initWithFrame:frame])) return nil;

    NSMutableArray *scrolls = [NSMutableArray arrayWithCapacity:sections];
    CGFloat minX = 0;
    for(NSInteger i=0;i<sections;i++){
        
        CGRect rect = self.bounds;
        rect.origin.x = minX;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
        scrollView.tag = i;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        minX = CGFrameGetMaxX(scrollView);
        [scrolls addObject:scrollView];
        
    }
    
    _currentSection = 0;
    
    
    self.scrollViews = scrolls.copy;
    
    return self;
}

#pragma mark UIScrollView Delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if([self.delegate respondsToSelector:@selector(sectionedScrollView:scrollViewDidScroll:)])
        [self.delegate sectionedScrollView:self scrollViewDidScroll:scrollView];
    
    if(self.currentSection == scrollView.tag){
        
        UIScrollView *nextScrollView = scrollView.tag + 1 < self.scrollViews.count ? self.scrollViews[scrollView.tag+1] : nil;
        UIScrollView *prevScrollView = scrollView.tag > 0 ? self.scrollViews[scrollView.tag-1] : nil;
        CGFloat endOffSet = scrollView.contentOffsetFromEnd.x;
        CGFloat starOffSet = scrollView.contentOffset.x;

        if(!self.movingPages){
            
            CGFloat x = CGFrameGetWidth(self) * nextScrollView.tag - (CGFrameGetWidth(self)*self.currentSection);
            CGFloat minX = MIN(x + endOffSet,x);
            nextScrollView.frame = CGRectMakeWithSize(minX,CGFrameGetMinY(nextScrollView), nextScrollView.frame.size);
            
            x = CGFrameGetWidth(self) * prevScrollView.tag - (CGFrameGetWidth(self)*self.currentSection);
            minX = MAX(x - starOffSet,x);
            prevScrollView.frame = CGRectMakeWithSize(minX,CGFrameGetMinY(prevScrollView), prevScrollView.frame.size);
            
            
        }

    }

}
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if([self.delegate respondsToSelector:@selector(sectionedScrollView:scrollViewWillBeginDragging:)])
        [self.delegate sectionedScrollView:self scrollViewWillBeginDragging:scrollView];
    
    self.canMoveLeft = self.canMoveRight = NO;
    if(scrollView.contentOffset.x < 5 && scrollView.tag > 0)
        self.canMoveLeft = YES;
    else if(scrollView.contentOffsetFromEnd.x < 5 && scrollView.tag + 1 < self.scrollViews.count)
        self.canMoveRight = YES;

}
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if([self.delegate respondsToSelector:@selector(sectionedScrollView:scrollViewDidEndDragging:willDecelerate:)])
        [self.delegate sectionedScrollView:self scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
    //CGPoint scrollVelocity = [[scrollView panGestureRecognizer] velocityInView:self];

    if(scrollView.contentOffsetFromEnd.x < 0 && self.canMoveRight){
        
        

        _currentSection = self.currentSection + 1;
        self.movingPages = YES;
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationCurveEaseInOut animations:^{
            NSInteger ctr = 0;
            for(UIScrollView *sv in self.scrollViews){
                CGFloat minX = (CGFrameGetWidth(self) * ctr) - (CGFrameGetWidth(self)*self.currentSection);
                sv.center = CGPointMake(minX + CGFrameGetWidth(sv)/2, sv.center.y);
                ctr++;
            }
        } completion:^(BOOL finished) {
            self.movingPages = NO;
        }];
        
        

        
        
        

    }else if(scrollView.contentOffset.x < 0 && self.canMoveLeft){
        
        _currentSection = self.currentSection - 1;
        
        
        self.movingPages = YES;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationCurveEaseInOut animations:^{
            NSInteger ctr = 0;
            for(UIScrollView *sv in self.scrollViews){
                CGFloat minX = (CGFrameGetWidth(self) * ctr) - (CGFrameGetWidth(self)*self.currentSection);
                
                sv.center = CGPointMake(minX + CGFrameGetWidth(sv)/2, sv.center.y);

                
                ctr++;
            }
        } completion:^(BOOL finished) {
            self.movingPages = NO;
        }];


    }
    
    
}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if([self.delegate respondsToSelector:@selector(sectionedScrollView:scrollViewDidEndDecelerating:)])

        [self.delegate sectionedScrollView:self scrollViewDidEndDecelerating:scrollView];
    
    
}

#pragma mark Properties
- (void) setCurrentSection:(NSInteger)currentSection{
    [self setCurrentSection:currentSection animated:NO];
}

- (void) setCurrentSection:(NSInteger)currentSection animated:(BOOL)animated{

    _currentSection = currentSection;
    
    if(animated){
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:0 animations:^{
            NSInteger ctr = 0;
            for(UIScrollView *sv in self.scrollViews){
                
                CGFloat minX = (CGFrameGetWidth(self) * ctr) - (CGFrameGetWidth(self)*self.currentSection);
                sv.center = CGPointMake(minX + CGFrameGetWidth(sv)/2, sv.center.y);
                
                CGFloat end = sv.contentSize.width - CGFrameGetWidth(sv);
                sv.contentOffset = CGPointMake( ctr >= _currentSection ? 0 : end , 0);
                
                ctr++;
            }
        } completion:nil];
        
    }else{
        
        [UIView performWithoutAnimation:^{
            NSInteger ctr = 0;
            for(UIScrollView *sv in self.scrollViews){
                
                CGFloat minX = (CGFrameGetWidth(self) * ctr) - (CGFrameGetWidth(self)*self.currentSection);
                sv.center = CGPointMake(minX + CGFrameGetWidth(sv)/2, sv.center.y);
                
                CGFloat end = sv.contentSize.width - CGFrameGetWidth(sv);
                sv.contentOffset = CGPointMake( ctr >= _currentSection ? 0 : end , 0);
                
                ctr++;
            }
        }];
    }
    
}

@end
