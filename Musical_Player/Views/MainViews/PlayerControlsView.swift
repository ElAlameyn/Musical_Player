import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
  func PLayerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView)
  func PLayerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
  func PLayerControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView)
  func PLayerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}

final class PlayerControlsView: UIView {

  private var isPlaying = true

  weak var delegate: PlayerControlsViewDelegate?

  private let slider = UISlider()
  private let nameLabel = UILabel()
  private let subtitleLabel = UILabel()
  private let backButton = UIButton()
  private let forwardButton = UIButton()
  private let pauseButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .systemBackground
    
    addBackButton()
    addForwardButton()
    addPauseButton()
    
    addNameLabel()
    addSubtitleLabel()
    addVolumeSlide()
    
    slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)

    backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    forwardButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    pauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
  }
  
  @objc func didSlideSlider(_ slider: UISlider) {
    let value = slider.value
    delegate?.PLayerControlsView(self, didSlideSlider: value)
  }

  
  @objc private func didTapPlayPause() {
    self.isPlaying.toggle()
    
    delegate?.PLayerControlsViewDidTapPlayPause(self)
    
    let pause = UIImage(systemName: Constants.controlsPauseButton, withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    let play = UIImage(systemName: Constants.controlsPlayButton, withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))

    pauseButton.setImage(isPlaying ? pause : play, for: .normal)
  }
  
  @objc private func didTapBack() {
    self.isPlaying = true
    delegate?.PLayerControlsViewDidTapBackwardButton(self)
    let pause = UIImage(systemName: Constants.controlsPauseButton, withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    pauseButton.setImage(pause, for: .normal)
  }
  
  @objc private func didTapNext() {
    self.isPlaying = true
    delegate?.PLayerControlsViewDidTapForwardButton(self)
    let pause = UIImage(systemName: Constants.controlsPauseButton, withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    pauseButton.setImage(pause, for: .normal)
  }

  
  private func addVolumeSlide() {
    slider.value = 0.5
    
    addSubview(slider)
    
    slider.addEdgeConstraints(exclude: .bottom, .top, .bottom, offset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: -10))
    slider.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
  }

  private func addNameLabel() {
    nameLabel.numberOfLines = 1
    nameLabel.font = .systemFont(ofSize: 20, weight: .regular)
    nameLabel.textColor = .secondaryLabel
    
    addSubview(nameLabel)
    
    nameLabel.text = "Song Name"
    
    nameLabel.addEdgeConstraints(exclude: .bottom, .top, offset: UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 5))
  }
  
  private func addSubtitleLabel() {
    subtitleLabel.numberOfLines = 1
    subtitleLabel.font = .systemFont(ofSize: 18, weight: .regular)
    subtitleLabel.textColor = .secondaryLabel
    
    addSubview(subtitleLabel)
    
    subtitleLabel.text = "Subtitle"
    subtitleLabel.addEdgeConstraints(exclude: .bottom, .bottom, offset: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5))
    subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
  }
  
  private func addBackButton() {
    backButton.tintColor = .label
    let image = UIImage(systemName: Constants.controlsBackButton, withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    backButton.setImage(image, for: .normal)
    
    addSubview(backButton)
    
    backButton.addEdgeConstraints(exclude: .top, .right, offset: UIEdgeInsets(top: 0, left: 20, bottom: -20, right: 0))
  }
  
  private func addForwardButton() {
    forwardButton.tintColor = .label
    let image = UIImage(systemName: Constants.controlsForwardButton, withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    forwardButton.setImage(image, for: .normal)
    
    addSubview(forwardButton)
    
    forwardButton.addEdgeConstraints(exclude: .top, .left, offset: UIEdgeInsets(top: 0, left: 0, bottom: -20, right: -20))
  }
  
  private func addPauseButton() {
    pauseButton.tintColor = .label
    let image = UIImage(systemName: Constants.controlsPauseButton, withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    pauseButton.setImage(image, for: .normal)
    
    addSubview(pauseButton)
    
    pauseButton.addCenterConstraints(exclude: .axisY)
    pauseButton.firstBaselineAnchor.constraint(equalTo: backButton.firstBaselineAnchor).isActive = true
  }
  
  func configure(with info: ViewModel) {
    nameLabel.text = info.title
    subtitleLabel.text = info.subtitle
  }


  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
}

extension PlayerControlsView  {

  struct ViewModel {
    let title: String?
    let subtitle: String?
  }
  
}
