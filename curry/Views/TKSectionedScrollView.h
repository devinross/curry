//
//  TKSectionedScrollView.h
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

@import UIKit;

@class TKSectionedScrollView;
@protocol TKSectionedScrollViewDelegate <NSObject>
@optional
- (void) sectionedScrollView:(TKSectionedScrollView*)sectionedScrollView scrollViewDidScroll:(UIScrollView *)scrollView;
- (void) sectionedScrollView:(TKSectionedScrollView*)sectionedScrollView scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void) sectionedScrollView:(TKSectionedScrollView*)sectionedScrollView scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void) sectionedScrollView:(TKSectionedScrollView*)sectionedScrollView scrollViewWillBeginDragging:(UIScrollView *)scrollView;
@end

@interface TKSectionedScrollView : UIView <UIScrollViewDelegate>

- (instancetype) initWithFrame:(CGRect)frame numberOfSections:(NSUInteger)sections;

@property (nonatomic,weak) id<TKSectionedScrollViewDelegate>delegate;
@property (nonatomic,strong) NSArray *scrollViews;
@property (nonatomic,assign) NSInteger currentSection;
@property (nonatomic,readonly) BOOL movingPages;

- (void) setCurrentSection:(NSInteger)currentSection animated:(BOOL)animated;


@end


@interface UIScrollView (Kit)
@property (nonatomic,assign,readonly) CGPoint contentOffsetFromEnd;
@end