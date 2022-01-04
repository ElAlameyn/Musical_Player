import UIKit
import Combine
import SDWebImage

class BaseViewController: UIViewController {
  
  private var tableView = UITableView()
  private var tracks = [AudioTrack]()
  private var subscriber: AnyCancellable?
  private var imageView = UIImageView()
  private var titleSong = UILabel()
  private var playerViewController: PlayerViewController?
  private var currentPlayablePosition: Float = 0
  
  var isPlaying = false

  private let slider = UISlider()
  private var sliderTimer: Timer?
  
  private var pauseButton = UIButton()
  
  private var currentIndexPath: IndexPath! {
    didSet {
      tableView.selectRow(at: currentIndexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
  }
  
  private var currentTrack: AudioTrack! {
    didSet {
      configTableViewWith(track: currentTrack)
      currentPlayablePosition = 0
      configSlider(duration: Float(currentTrack.duration_ms))
    }
  }
  
  private var currentImageURL: String = "" {
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
    
    addTitleSong()
    
    addSlider()
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
      
      self?.subscriber = SpotifyAPI.shared.getRecommendations(seeds: seeds)?.sink(receiveCompletion: {_ in}) {[weak self] result in
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
    
    imageView.addEdgeConstraints(exclude: .bottom, .top, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    imageView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 20).isActive = true
    imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    imageView.layer.cornerRadius = 20
    imageView.contentMode = .scaleAspectFill
    imageView.layer.zPosition = -1
    imageView.alpha = 0.9
    
    let darkView = UIView()
    darkView.backgroundColor = .black
    darkView.alpha = 0.65
    darkView.frame = imageView.frame
    imageView.addSubview(darkView)
    
    darkView.addEdgeConstraints(exclude: .top, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    darkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
  }
  
  private func addDownArrow() {
    let image = UIImage(systemName: "chevron.compact.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(30)))?
      .withTintColor(.white, renderingMode: .alwaysOriginal)
    
    let button = UIButton()
    button.setImage(image, for: .normal)
    view.addSubview(button)
    
    button.addCenterConstraints(exclude: .axisY)
    button.addEdgeConstraints(exclude: .top, .left, .right, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    button.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
    button.addTarget(self, action: #selector(didTapDown), for: .touchUpInside)
  }
  
  
  
  private func addPause() {
    let image = UIImage(systemName: "pause.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(40)))?
      .withTintColor(.white, renderingMode: .alwaysOriginal)
    
    pauseButton = UIButton()
    pauseButton.setImage(image, for: .normal)
    view.addSubview(pauseButton)
    
    pauseButton.addCenterConstraints(exclude: .axisY)
    pauseButton.addEdgeConstraints(exclude: .top, .left, .right, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    pauseButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -45).isActive = true
    
    pauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
  }
  
  private func addRightArrow() {
    let image = UIImage(systemName: "chevron.right.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(30)))?
      .withTintColor(.white, renderingMode: .alwaysOriginal)
    let button = UIButton()
    button.setImage(image, for: .normal)
    
    view.addSubview(button)
    
    button.addCenterConstraints(exclude: .axisY, offset: CGPoint(x: 150, y: 0))
    button.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -50).isActive = true
    button.sizeToFit()
    
    button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
  }
  
  
  
  private func addLeftArrow() {
    let image = UIImage(systemName: "chevron.backward.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(30)))?
      .withTintColor(.white, renderingMode: .alwaysOriginal)
    
    let button = UIButton()
    button.setImage(image, for: .normal)
    view.addSubview(button)
    
    button.addCenterConstraints(exclude: .axisY, offset: CGPoint(x: -150, y: -10))
    button.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -50).isActive = true
    
    button.addTarget(self, action: #selector(didTapPrevious), for: .touchUpInside)
  }
  
  private func addTitleSong() {
    titleSong = UILabel()
    titleSong.text = "Choose track to play"
    titleSong.numberOfLines = 0
    titleSong.textAlignment = .left
    titleSong.textColor = .white
    titleSong.font = .preferredFont(forTextStyle: .title2)
    
    imageView.addSubview(titleSong)
    titleSong.addEdgeConstraints(exclude: .bottom, offset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
  }
  
  private func addSlider() {
    let image = UIImage(named: "sliderCircle")
    let imageSize = CGSize(width: 20, height: 20)
    let renderer = UIGraphicsImageRenderer(size: imageSize)
    let scaledImage = renderer.image { _ in
      image?.draw(in: CGRect(origin: .zero, size: imageSize))
    }
    
    slider.setThumbImage(scaledImage, for: .normal)
    slider.setThumbImage(scaledImage, for: .normal)
    slider.value = 0
    slider.maximumValue = 1
    slider.minimumValue = 0
    view.addSubview(slider)
    slider.topAnchor.constraint(equalTo: titleSong.bottomAnchor, constant: 10).isActive = true
    slider.addEdgeConstraints(exclude: .top, .bottom, offset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: -10))
    slider.sizeToFit()
    slider.layer.zPosition = 2
  }
  
  // MARK: - Slider Configuration
  
  private func configSlider(duration: Float) {
    slider.maximumValue = duration / 1000
    slider.value = currentPlayablePosition

    sliderTimer?.invalidate()
    sliderTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[weak self] timer in
      guard let slider = self?.slider else {
        timer.invalidate()
        self?.currentPlayablePosition = 0
        return
      }
      
      if slider.value != slider.maximumValue {
        slider.setValue(slider.value + 1, animated: true)
        self?.currentPlayablePosition += 1
      } else {
        self?.currentPlayablePosition = 0
        timer.invalidate()
      }
    }
  }
  
  private func sliderStop() {
    sliderTimer?.invalidate()
  }
  
  private func continueSliderMoving() {
    sliderTimer?.invalidate()
    slider.value = Float(AudioPlayer.shared.currentPlayableTime ?? Double(currentPlayablePosition))
    sliderTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[weak self] timer in
      guard let slider = self?.slider else {
        self?.currentPlayablePosition = 0
        timer.invalidate()
        return
      }
      if slider.value != slider.maximumValue {
        slider.setValue(slider.value + 1, animated: true)
      } else {
        self?.currentPlayablePosition = 0
        timer.invalidate()
      }
    }
  }
  
  // MARK: - Navigation Buttons

  @objc func didTapNext() {
    pauseButton.setFor(imageName: "pause.circle")
    if currentTrack != nil, let track = tracks.after(currentTrack) {
      isPlaying = true
      self.currentTrack = track
      self.currentIndexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
    }
  }
  
  @objc func didTapPrevious() {
    pauseButton.setFor(imageName: "pause.circle")
    if currentTrack != nil, let track = tracks.before(currentTrack) {
      isPlaying = true
      self.currentTrack = track
      self.currentIndexPath = IndexPath(row: currentIndexPath.row - 1, section: 0)
    }
  }
  
  
  @objc func didTapPlayPause() {
    if isPlaying {
      sliderStop()
      pauseButton.setFor(imageName: "play.circle")
      AudioPlayer.shared.pause()
    } else {
      continueSliderMoving()
      pauseButton.setFor(imageName: "pause.circle")
      AudioPlayer.shared.play()
    }
    isPlaying.toggle()
  }
  
  @objc func didTapDown() {
    
  }
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tracks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: TrackViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
    let track = tracks[indexPath.row]
    
    cell.viewModel = PlayerViewController.ViewModel(
      songName: track.name,
      subtitle: track.artists.first?.name ?? "",
      imageURL: track.album?.images.first?.url ?? "",
      duration: track.duration_ms)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    currentTrack = tracks[indexPath.row]
    currentIndexPath = indexPath
    //    selectAndPlayChosenTrack(track: tracks[indexPath.row])
    let timeFormatter = TimeFormatter()
    print(timeFormatter.getFormattedDurationString(trackDuration: tracks[indexPath.row].duration_ms as NSNumber))
    
    isPlaying = true
    //    configSlider(duration: Float(tracks[indexPath.row].duration_ms), currentPosition: 0)
  }
  
  private func configTableViewWith(track: AudioTrack?) {
    
    guard let track = track else {
      return
    }
    
    currentImageURL = track.album?.images.first?.url ?? ""
    titleSong.text = track.name
    
    AudioPlayer.shared.tracks = tracks
    AudioPlayer.shared.track = track
    
    AudioPlayer.shared.playTrack()
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
