import UIKit

protocol PlayerDataSource: AnyObject {
  var songName: String? { get }
  var subtitle: String? { get }
  var imageURL: URL? { get }
}

final class PlaybackPresenter {
  static let shared = PlaybackPresenter()
  
  private var track: AudioTrack?
  private var tracks = [AudioTrack]()
  
  var currentTrack: AudioTrack? {
    if let track = track, !tracks.isEmpty {
      return track
    } else if !tracks.isEmpty {
      return tracks.first
    }
    
    return nil
  }
  
  //call in didselectrowat
  
  func startPlayback(from viewController: UIViewController, track: AudioTrack) {
    
    self.track = track
    self.tracks = []

    let playerViewController = PlayViewController()
    playerViewController.title = track.name
    playerViewController.dataSource = self
    viewController.present(UINavigationController(rootViewController: playerViewController), animated: true, completion: nil)
  }
}

extension PlaybackPresenter: PlayerDataSource {
  var songName: String? {
    currentTrack?.name
  }
  
  var subtitle: String? {
    currentTrack?.artists.first?.name
  }
  
  var imageURL: URL? {
    URL(string: currentTrack?.album?.images.first?.url ?? "")
  }
}
