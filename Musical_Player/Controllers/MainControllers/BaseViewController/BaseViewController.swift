import UIKit
import Combine

class BaseViewController: UIViewController {
  
  var tableView = UITableView()
  var tracks = [AudioTrack]()

  var subscriber: AnyCancellable?
  
  var playerViewController: PlayerViewController?
  

  
  override func viewDidLoad() {
    view.backgroundColor = .systemBackground

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
    
    tableView.register(TrackViewCell.self)
    
    view.addSubview(tableView)
    
    tableView.addEdgeConstraints(offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    
    tableView.tableHeaderView = BaseHeaderView()
  }
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tracks.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: TrackViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
    cell.viewModel = PlayerViewController.ViewModel(songName: tracks[indexPath.row].name, subtitle: tracks[indexPath.row].artists.first?.name ?? "", imageURL: tracks[indexPath.row].album?.images.first?.url ?? "")
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectAndPlayChosenTrack(track: tracks[indexPath.row])
  }
  
  private func selectAndPlayChosenTrack(track: AudioTrack) {

    AudioPlayer.shared.tracks = tracks
    AudioPlayer.shared.track = track
    
    let playback = PlayerPresenter(with: track)
    
    AudioPlayer.shared.playTrack()

    guard let playerViewController = playback.playerViewController else { return }
    present(UINavigationController(rootViewController: playerViewController),
            animated: true,
            completion: {
    })
  }
  
}
