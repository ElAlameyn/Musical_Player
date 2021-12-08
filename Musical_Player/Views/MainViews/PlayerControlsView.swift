import UIKit

final class PLayerControlsView: UIView {
  
  private let slider = UISlider()
  private let nameLabel = UILabel()
  private let subtitleLabel = UILabel()
  private let backButton = UIButton()
  private let forwardButton = UIButton()
  private let pauseButton = UIButton()
  
  private func addVolumeSlide() {
    slider.value = 0.5
    
    addSubview(slider)
    
    slider.addEdgeConstraints(exclude: .top, .bottom, offset: UIEdgeInsets(top: 5, left: 10, bottom: 10, right: -10))
    slider.bottomAnchor.constraint(equalTo: pauseButton.topAnchor, constant: -10).isActive = true
  }

  private func addNameLabel() {
    nameLabel.numberOfLines = 1
    nameLabel.font = .systemFont(ofSize: 20, weight: .regular)
    nameLabel.textColor = .secondaryLabel
    
    addSubview(nameLabel)
    
    nameLabel.text = "Song Name"
    
    nameLabel.addEdgeConstraints(exclude: .bottom, .top, offset: UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5))
    nameLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -10).isActive = true
  }
  
  private func addSubtitleLabel() {
    subtitleLabel.numberOfLines = 1
    subtitleLabel.font = .systemFont(ofSize: 18, weight: .regular)
    subtitleLabel.textColor = .secondaryLabel
    
    addSubview(subtitleLabel)
    
    subtitleLabel.text = "Subtitle"
    subtitleLabel.addEdgeConstraints(exclude: .top, .bottom, offset: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    subtitleLabel.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -10).isActive = true
  }
  
  private func addBackButton() {
    backButton.tintColor = .label
    let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    backButton.setImage(image, for: .normal)
    
    addSubview(backButton)
    
    backButton.addEdgeConstraints(exclude: .top, .right, offset: UIEdgeInsets(top: 0, left: 20, bottom: -20, right: 0))
  }
  
  private func addForwardButton() {
    forwardButton.tintColor = .label
    let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    forwardButton.setImage(image, for: .normal)
    
    addSubview(forwardButton)
    
    forwardButton.addEdgeConstraints(exclude: .top, .left, offset: UIEdgeInsets(top: 0, left: 0, bottom: -20, right: -20))
  }
  
  private func addPauseButton() {
    pauseButton.tintColor = .label
    let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    pauseButton.setImage(image, for: .normal)
    
    addSubview(pauseButton)
    
    pauseButton.addCenterConstraints(exclude: .axisY)
    pauseButton.firstBaselineAnchor.constraint(equalTo: backButton.firstBaselineAnchor).isActive = true
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addBackButton()
    addForwardButton()
    addPauseButton()
    
    addVolumeSlide()
    
    addSubtitleLabel()
    addNameLabel()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.backgroundColor = .red
    
  }
}
