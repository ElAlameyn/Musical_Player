import UIKit
import Combine

class BaseViewController: UIViewController {
  
  var tableView = UITableView()
  var tracks = [AudioTrack]() {
    didSet {
//      AudioPlayer.shared.tracks = tracks
    }
  }
  var backwardTrack: AudioTrack?
  var forwardTrack: AudioTrack?
  
  
  var subscriber: AnyCancellable?
  var subscriber2: AnyCancellable?
  
  override func viewDidLoad() {
    view.backgroundColor = .systemBackground
    title = "Featured  Tracks"
    
    configTableView()
    getFeaturedTrack()

  }
  
  private func getFeaturedTrack() {
    subscriber = SpotifyAPI.shared.getGenres().sink(receiveCompletion: {_ in}) {[weak self] result in
      
      var values = Set<String>()
      _ = result.genres.reduce(0) { res, el in
        if res < 5 { values.insert(el)}
        return res + 1
      }
      
      let seeds = values.joined(separator: ",")
      self?.subscriber?.cancel()
      
      self?.subscriber = SpotifyAPI.shared.getRecommendations(seeds: seeds).sink(receiveCompletion: {_ in}) {[weak self] result in
        self?.tracks = result.tracks
        self?.tableView.reloadData()
      }
    }
  }
  
  private func testReadFromFile() {
    guard let fileURL = Bundle.main.url(forResource: "music", withExtension: "json") else { return }
    guard let data = try? Data(contentsOf: fileURL) else {
      fatalError()
    }
    
    do {
      let trackResponse: AudioTrack = try StorageManager.shared.parse(json: data)
      tracks.append(trackResponse)
    } catch {
      print("Failed to read from file")
    }
  }
  
  
  private func configTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(UITableViewCell.self)
    
    view.addSubview(tableView)
    
    tableView.addEdgeConstraints(offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tracks.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(indexPath: indexPath)
    cell.textLabel?.text = tracks[indexPath.row].name
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectAndPlayChosenTrack(track: tracks[indexPath.row])
  }
  
  private func openAndPlay(track: AudioTrack, in viewController: PlayerViewController) {
    AudioPlayer.shared.track = track

    viewController.configure(
      with: PlayerViewController.ViewModel(
        songName: track.name,
        subtitle: track.artists.first?.name ?? "",
        imageURL: track.album?.images.first?.url ?? ""
      )
    )
    
    AudioPlayer.shared.selectAndPlayChosenTrack(track: track)
  }

  private func selectAndPlayChosenTrack(track: AudioTrack) {
    let playerViewController = PlayerViewController()
    playerViewController.title = track.name
    
    backwardTrack = track
    forwardTrack = track
    
    openAndPlay(track: track, in: playerViewController)

    playerViewController.backward = { [weak self] in
      guard let existBackward = self?.backwardTrack else { return }
      guard let newBackwardTrack = self?.tracks.before(existBackward) else { return }
      self?.backwardTrack = newBackwardTrack
      
      self?.openAndPlay(track: newBackwardTrack, in: playerViewController)
      self?.forwardTrack = self?.backwardTrack
    }
    
    playerViewController.forward = { [weak self] in
      guard let existForward = self?.forwardTrack else { return }
      guard let newForwardTrack = self?.tracks.after(existForward) else { return }
      self?.forwardTrack = newForwardTrack
      
      self?.openAndPlay(track: newForwardTrack, in: playerViewController)
      self?.backwardTrack = self?.forwardTrack
    }

    present(UINavigationController(rootViewController: playerViewController),
            animated: true,
            completion: {
    })
  }
}
