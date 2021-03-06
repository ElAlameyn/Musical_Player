import UIKit
import AVFoundation

final class AudioPlayer {
  static let shared = AudioPlayer()
  
  private var player: AVPlayer?
  private var playerQueue: AVQueuePlayer?
  
  var track: AudioTrack?
  var tracks = [AudioTrack]()

  var currentPlayableTime: Double? {
    AVCurrentItem?.currentTime().seconds
  }

  var AVitems: [AVPlayerItem] {
    tracks.compactMap { track in
      guard let url = URL(string: track.preview_url ?? "") else { return nil }
      return AVPlayerItem(url: url)
    }
  }
  
  var AVCurrentItem: AVPlayerItem? {
    guard let url = URL(string: track?.preview_url ?? "") else { return nil }
    return AVPlayerItem(url: url)
  }

  public func playTrack() {
    player?.pause()
    player = AVPlayer(playerItem: AVCurrentItem)
    player?.play()
  }
  
  public func playTracks() {
    playerQueue?.pause()

    guard !AVitems.isEmpty else { return }
    
    playerQueue = AVQueuePlayer(items: AVitems)
    playerQueue?.play()
  }
  

  public func playNext() {
    playerQueue?.pause()
    player = nil

    guard let currentTrack = track, let track = tracks.after(currentTrack) else { return }
    self.track = track
    playTrack()
  }
  
  public func playPrevious() {
    playerQueue?.pause()
    player = nil
      
    guard let currentTrack = track, let track = tracks.before(currentTrack) else { return }
    self.track = track
    playTrack()
  }
  
  public func play() {
    player?.play()
  }
  
  public func pause() {
    player?.pause()
  }
  
  public func changeVolumeWith(_ value: Float) {
    player?.volume = value
  }

}
