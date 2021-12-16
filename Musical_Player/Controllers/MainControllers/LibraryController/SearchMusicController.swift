
import UIKit
import Combine

class SearchMusicController: UIViewController, UISearchResultsUpdating {
  
  let searchController = UISearchController()
  var tracks = [AudioTrack]()
  var currentOffset = 0
  var isLoading = false
  var subscriber: AnyCancellable?
  var tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Search"
    view.backgroundColor = .systemBackground
    
    navigationItem.searchController = searchController
    searchController.searchResultsUpdater = self
    
    configTableView()
  }
  
  private func configTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(TrackViewCell.self)
    
    view.addSubview(tableView)
    
    tableView.addEdgeConstraints(offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
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
  
  func updateSearchResults(for searchController: UISearchController) {
    guard !self.isLoading else { return }
    subscriber = NotificationCenter.default
      .publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
      .map({($0.object as? UISearchTextField)?.text})
      .receive(on: RunLoop.main)
      .sink(receiveValue: {[weak self] text in
        if let text = text {

          guard text.count > 2 else { return }
          self?.currentOffset = 0
          self?.isLoading = true
          
          self?.subscriber = SpotifyAPI.shared.getSearchedTracks(queue: text, offset: self?.currentOffset ?? 0)
            .sink(receiveCompletion: {_ in} , receiveValue: { tracks in
              self?.tracks = tracks.tracks.items
              DispatchQueue.main.async {
                self?.tableView.reloadData()
              }
              self?.isLoading = false
            })
        }
      })
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let lastElement = tracks.count - 1
    if indexPath.row == lastElement && !isLoading {
      if let text = searchController.searchBar.text {
        currentOffset += 20
        isLoading = true
        
        let oldCount = self.tracks.count
        
        self.subscriber = SpotifyAPI.shared.getSearchedTracks(queue: text, offset: currentOffset)
          .sink(receiveCompletion: {_ in} , receiveValue: { tracks in
            self.tracks.append(contentsOf: tracks.tracks.items)
            DispatchQueue.main.async { [weak self] in
              let indexPaths = (oldCount ..< (oldCount + tracks.tracks.items.count)).map { index in
                IndexPath(row: index, section: 0)
              }
              self?.tableView.insertRows(at: indexPaths, with: .automatic)
            }
            self.isLoading = false
          })
      }
    }
  }
}


extension SearchMusicController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tracks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: TrackViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
    cell.viewModel = PlayerViewController.ViewModel(songName: tracks[indexPath.row].name, subtitle: tracks[indexPath.row].artists.first?.name ?? "", imageURL: tracks[indexPath.row].album?.images.first?.url ?? "")
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectAndPlayChosenTrack(track: tracks[indexPath.row])
  }
}
