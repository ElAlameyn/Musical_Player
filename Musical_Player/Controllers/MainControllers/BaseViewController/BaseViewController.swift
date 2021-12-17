import UIKit
import Combine
import SDWebImage

class BaseViewController: UIViewController {
  
  var tableView = UITableView()
  var tracks = [AudioTrack]()

  var subscriber: AnyCancellable?
  
  var imageView = UIImageView()
  
  var playerViewController: PlayerViewController?
  var currentImageURL: String = "" {
    didSet {
      imageView.sd_setImage(with: URL(string: currentImageURL))
    }
  }
  

  override func viewDidLoad() {
    view.backgroundColor = .systemBackground

    configTableView()
    getFeaturedTrack()
    
    addImageView()
    addDownArrow()
    addRightArrow()
    addLeftArrow()
    addPause()
  }
  
  private func getFeaturedTrack() {
    subscriber = SpotifyAPI.shared.getGenres()?.sink(receiveCompletion: {_ in}) {[weak self] result in
      
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
  
  
  // MARK: - Private
  
  private func configTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.layer.cornerRadius = 20
    tableView.layer.borderColor = UIColor.black.cgColor
    
    tableView.register(TrackViewCell.self)
    
    view.addSubview(tableView)
    
    tableView.addEdgeConstraints(offset: UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0))
    
    tableView.tableHeaderView = BaseHeaderView()
  }
  
  private func addImageView() {
    view.addSubview(imageView)
    
    imageView.addEdgeConstraints(exclude: .bottom, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    imageView.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
    imageView.layer.cornerRadius = 20
    imageView.contentMode = .scaleAspectFill
    imageView.layer.zPosition = -1
    imageView.alpha = 0.25
  }
  
  private func addDownArrow() {
    let image = UIImage(systemName: "chevron.compact.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(50)))?
      .withTintColor(.black, renderingMode: .alwaysOriginal)
    let downImageView = UIImageView(image: image)
    
    view.addSubview(downImageView)
    
    downImageView.addCenterConstraints(exclude: .axisY)
    downImageView.addEdgeConstraints(exclude: .top, .left, .right, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    downImageView.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
  }
  
  private func addPause() {
    let image = UIImage(systemName: "pause.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(50)))?
      .withTintColor(.black, renderingMode: .alwaysOriginal)
    let downImageView = UIImageView(image: image)
    
    view.addSubview(downImageView)
    
    downImageView.addCenterConstraints(exclude: .axisY)
    downImageView.addEdgeConstraints(exclude: .top, .left, .right, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    downImageView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -50).isActive = true
  }
  
  private func addRightArrow() {
    let rightImage = UIImage(systemName: "chevron.right.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(50)))?
      .withTintColor(.black, renderingMode: .alwaysOriginal)
    let rightButtonImageView = UIImageView(image: rightImage)
    
    view.addSubview(rightButtonImageView)
    
    rightButtonImageView.addCenterConstraints(exclude: .axisY, offset: CGPoint(x: 150, y: -10))
    rightButtonImageView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -50).isActive = true
  }
  
  private func addLeftArrow() {
    let image = UIImage(systemName: "chevron.backward.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(50)))?
      .withTintColor(.black, renderingMode: .alwaysOriginal)
    let rightButtonImageView = UIImageView(image: image)
    
    view.addSubview(rightButtonImageView)
    
    rightButtonImageView.addCenterConstraints(exclude: .axisY, offset: CGPoint(x: -150, y: -10))
    rightButtonImageView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -50).isActive = true
  }
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tracks.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: TrackViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
<<<<<<< HEAD
    cell.viewModel = PlayerViewController.ViewModel(songName: tracks[indexPath.row].name,
                                                    subtitle: tracks[indexPath.row].artists.first?.name ?? "",
                                                    imageURL: tracks[indexPath.row].album?.images.first?.url ?? ""
    )
=======
    cell.viewModel = PlayerViewController.ViewModel(songName: tracks[indexPath.row].name, subtitle: tracks[indexPath.row].artists.first?.name ?? "", imageURL: tracks[indexPath.row].album?.images.first?.url ?? "",
                                                    duration: tracks[indexPath.row].duration_ms)
>>>>>>> feature/lab2
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    selectAndPlayChosenTrack(track: tracks[indexPath.row])
    currentImageURL = tracks[indexPath.row].album?.images.first?.url ?? ""
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
