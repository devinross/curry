//
//  TKSoundAlertController.swift
//  Created by Devin Ross on 3/10/14.
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

import Foundation
import AVFoundation
import AudioToolbox


/** `TKSoundAlertController` plays simple user interface sounds. */
@objc(TKSoundAlertController)
open class TKSoundAlertController: NSObject, AVAudioPlayerDelegate {
	
	/** Returns the singleton sound alert controller. */
	@objc public static let sharedInstance = TKSoundAlertController()
	
	/** Flag to enable the play of the sound. If off, it will not play the sound. Default is off. */
	@objc open var isOn: Bool = false
	
	private var sounds: [String: SystemSoundID] = [:]
	
	/** Plays a sound file with name 'insert-sound-name'.aif */
	@objc(playAIF:)
	public static func playAIF(_ soundName: String) {
		sharedInstance.playSound(name: soundName, type: "aif")
	}
	
	/** Plays a sound file with name 'insert-sound-name'.aiff */
	@objc(playAIFF:)
	public static func playAIFF(_ soundName: String) {
		sharedInstance.playSound(name: soundName, type: "aiff")
	}
	
	/** Plays a sound file with name 'insert-sound-name'.wav */
	@objc(playWAV:)
	public static func playWAV(_ soundName: String) {
		sharedInstance.playSound(name: soundName, type: "wav")
	}
	
	/** Plays a sound file with name 'insert-sound-name'.caf */
	@objc(playCAF:)
	public static func playCAF(_ soundName: String) {
		sharedInstance.playSound(name: soundName, type: "caf")
	}
	
	@objc public static func vibrate() {
		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
	}
	
	/** Play a sound.
	@param soundName The name of the sound file.
	@param type The file extension.
	*/
	@objc(playSoundName:type:)
	open func playSound(name soundName: String, type: String) {
		
		guard isOn else { return }
		
		if let existing = sounds[soundName] {
			AudioServicesPlaySystemSound(existing)
			return
		}
		
		guard let path = Bundle.main.path(forResource: soundName, ofType: type) else { return }
		
		var soundID: SystemSoundID = 0
		guard AudioServicesCreateSystemSoundID(URL(fileURLWithPath: path) as CFURL, &soundID) == noErr else { return }
		
		sounds[soundName] = soundID
		AudioServicesPlaySystemSound(soundID)
	}
	
}
