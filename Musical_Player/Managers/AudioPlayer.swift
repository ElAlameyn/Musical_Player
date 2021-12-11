import UIKit
import AVFoundation

final class AudioPlayer {
  static let shared = AudioPlayer()
  
  var player: AVPlayer?
  var track: AudioTrack?
  
  public func playTrack(with url: URL) {
    player = AVPlayer(url: url)
    player?.play()
  }

  public func stopCurrentTrack() {
    player?.pause()
  }
  
  public func exchange() {
    if player?.timeControlStatus == .paused {
      player?.play()
    } else {
      player?.pause()
    }
  }
  
  func selectAndPlayChosenTrack(track: AudioTrack) {
    stopCurrentTrack()
    
    if let url = URL(string: track.preview_url ?? "") {
      self.track = track
      playTrack(with: url)
    }
  }
  
}
