//
//  TKVideoViewController.m
//  Created by Devin Ross on 6/24/15.
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

#import "TKVideoViewController.h"

@interface TKPlayerView : UIView
@property (nonatomic, retain) AVPlayer* player;
@end

@implementation TKPlayerView

+ (Class) layerClass{
	return [AVPlayerLayer class];
}
- (AVPlayer*) player{
	return [(AVPlayerLayer*)[self layer] player];
}
- (void) setPlayer:(AVPlayer*)player{
	[(AVPlayerLayer*)[self layer] setPlayer:player];
}

@end

@interface TKVideoViewController ()
@property (nonatomic,strong) TKPlayerView *videoView;
@property (nonatomic,copy) NSString *videoTitle;
@property (nonatomic,copy) NSString *videoType;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,assign) NSInteger currentLoop;
@end

@implementation TKVideoViewController

- (instancetype) initWithVideoTitle:(NSString*)title ofType:(NSString*)type{
	if(!(self=[super init])) return nil;
	self.videoTitle = title;
	self.videoType = type;
	return self;
}
- (instancetype) initWithURL:(NSURL*)url{
	if(!(self=[super init])) return nil;
	self.url = url;
	return self;
}
- (void) dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark View Lifecycle
- (void) loadView{
	[super loadView];
	self.videoView = [[TKPlayerView alloc] initWithFrame:self.view.bounds];
	self.videoGravity = AVLayerVideoGravityResizeAspectFill;
	self.videoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:self.videoView];
}
- (void) viewDidLoad{
	[super viewDidLoad];
	[self _setupPlayer];
}
- (void) _setupPlayer{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
	NSURL *url;
	if(self.url){
		url = self.url;
	}else{
		NSString *videoFile = [[NSBundle mainBundle] pathForResource:self.videoTitle ofType:self.videoType];
		url = [NSURL fileURLWithPath:videoFile];
	}
	self.player = [[AVPlayer alloc] initWithURL:url];
	self.player.actionAtItemEnd =  AVPlayerActionAtItemEndNone;
	self.videoView.player = self.player;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
}
- (void) viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
	self.player = nil;
	[self.videoView removeFromSuperview];
	self.videoView = nil;
	self.view = nil;
}

#pragma mark Notifications
- (void) playerItemDidReachEnd:(NSNotification *)notification{
	if(!self.shouldLoop) return;
	if(self.loopCount > 0 && self.currentLoop >= self.loopCount) return;
	self.currentLoop++;
	AVPlayerItem *p = [notification object];
	[p seekToTime:kCMTimeZero];
}

#pragma mark Actions
- (void) seekToBeginning{
	[self.player pause];
	[self.player seekToTime:kCMTimeZero];
}
- (void) play{
	[self.player play];
	self.currentLoop = 1;
}
- (void) pause{
	[self.player pause];
}
- (void) restart{
	if([self isViewLoaded] && self.view.superview){
		[self _setupPlayer];
		[self.player play];
	}
}


#pragma mark Properties
- (void) setVideoGravity:(NSString*)videoGravity{
	[(AVPlayerLayer*)self.videoView.layer setVideoGravity:videoGravity];
}
- (NSString*) videoGravity{
	return [(AVPlayerLayer*)self.videoView.layer videoGravity];
}


@end
