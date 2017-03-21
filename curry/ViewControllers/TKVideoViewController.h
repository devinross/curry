//
//  TKVideoViewController.h
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

@import UIKit;
@import AVFoundation;

/** `TKVideoViewController` is view controller dedicating to playing a video file from disk. */
@interface TKVideoViewController : UIViewController

/** Initializes a video view controller that will load the given `NSURL` object.
 @param title A `NSString` of the video file name.
 @param type A `NSString` of the video file extension.
 @return An initialized `TKVideoViewController` object or nil if the object couldn’t be created.
 */
- (instancetype) initWithVideoTitle:(NSString*)title ofType:(NSString*)type;

- (instancetype) initWithURL:(NSURL*)url;

///----------------------------
/// @name Properties
///----------------------------

/** The `AVPlayer` object. */
@property (nonatomic,strong) AVPlayer *player;

/** The gravity of the video aspect. */
@property (nonatomic,strong) NSString *videoGravity;

/** A flag to set to have the video play over and over again. */
@property (nonatomic,assign) BOOL shouldLoop;

@property (nonatomic,assign) NSInteger loopCount;



///----------------------------
/// @name Methods
///----------------------------
/** A flag to set to have the video play over and over again. */
- (void) play;
/** A flag to set to have the video play over and over again. */
- (void) pause;
/** A flag to set to have the video play over and over again. */
- (void) restart;
/** Set  */
- (void) seekToBeginning;


/** A notification that the player did reach the end of the video.
 @param notification The `NSNotification` object that called the method.
 */
- (void) playerItemDidReachEnd:(NSNotification *)notification;

@end
