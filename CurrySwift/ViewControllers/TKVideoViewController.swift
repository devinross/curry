//
//  TKVideoViewController.swift
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

import UIKit
import AVFoundation


/// A view backed by an `AVPlayerLayer`.
private final class TKPlayerView: UIView {
	
	override class var layerClass: AnyClass { AVPlayerLayer.self }
	
	private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
	
	var player: AVPlayer? {
		get { playerLayer.player }
		set { playerLayer.player = newValue }
	}
	
	var videoGravity: AVLayerVideoGravity {
		get { playerLayer.videoGravity }
		set { playerLayer.videoGravity = newValue }
	}
	
}


@objc(TKVideoViewController)
open class TKVideoViewController: UIViewController {
	
	@objc open var player: AVPlayer?
	
	/** Whether the video restarts when it reaches the end. */
	@objc open var shouldLoop: Bool = false
	
	/** How many times the video loops. Zero, the default, means without limit. */
	@objc open var loopCount: Int = 0
	
	private var videoView: TKPlayerView?
	private var videoTitle: String?
	private var videoType: String?
	private var url: URL?
	private var currentLoop: Int = 0
	
	@objc(initWithVideoTitle:ofType:)
	public init(videoTitle title: String, ofType type: String) {
		videoTitle = title
		videoType = type
		super.init(nibName: nil, bundle: nil)
	}
	
	@objc(initWithURL:)
	public init(url: URL) {
		self.url = url
		super.init(nibName: nil, bundle: nil)
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	// MARK: - View Lifecycle
	
	open override func loadView() {
		super.loadView()
		
		let created = TKPlayerView(frame: view.bounds)
		created.videoGravity = .resizeAspectFill
		created.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		videoView = created
		view.addSubview(created)
	}
	
	open override func viewDidLoad() {
		super.viewDidLoad()
		setupPlayer()
	}
	
	private func setupPlayer() {
		
		NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
		
		let source: URL?
		if let url {
			source = url
		} else if let videoTitle, let path = Bundle.main.path(forResource: videoTitle, ofType: videoType) {
			source = URL(fileURLWithPath: path)
		} else {
			source = nil
		}
		
		guard let source else { return }
		
		let created = AVPlayer(url: source)
		created.actionAtItemEnd = .none
		player = created
		videoView?.player = created
		
		NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(_:)),
		                                       name: .AVPlayerItemDidPlayToEndTime, object: created.currentItem)
	}
	
	open override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
		player = nil
		videoView?.removeFromSuperview()
		videoView = nil
	}
	
	// MARK: - Notifications
	
	@objc(playerItemDidReachEnd:)
	open func playerItemDidReachEnd(_ notification: Notification) {
		guard shouldLoop else { return }
		guard loopCount <= 0 || currentLoop < loopCount else { return }
		currentLoop += 1
		(notification.object as? AVPlayerItem)?.seek(to: .zero, completionHandler: nil)
	}
	
	// MARK: - Actions
	
	@objc open func seekToBeginning() {
		player?.pause()
		player?.seek(to: .zero)
	}
	
	@objc open func play() {
		player?.play()
		currentLoop = 1
	}
	
	@objc open func pause() {
		player?.pause()
	}
	
	@objc open func restart() {
		guard isViewLoaded, view.superview != nil else { return }
		setupPlayer()
		player?.play()
	}
	
	// MARK: - Properties
	
	@objc open var videoGravity: String {
		get { videoView?.videoGravity.rawValue ?? AVLayerVideoGravity.resizeAspectFill.rawValue }
		set { videoView?.videoGravity = AVLayerVideoGravity(rawValue: newValue) }
	}
	
}
