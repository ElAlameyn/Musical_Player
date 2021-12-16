import SDWebImage
import UIKit

class PlayerViewController: UIViewController {
  
  private let controllerView = PlayerControlsView()
  private let imageView = UIImageView()
  
  var viewModel: ViewModel? {
    didSet {
      configure()
    }
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = .systemBackground
      
      configureBarButtons()
      addControllerView()
      addImageView()
      
      configure()

      controllerView.delegate = self
    }
  
  private func configure() {
    imageView.sd_setImage(with: URL(string: viewModel?.imageURL ?? ""), completed: nil)
    
    controllerView.configure(
      with: PlayerControlsView.ViewModel(
        title: viewModel?.songName ?? "",
        subtitle: viewModel?.subtitle ?? ""))
  }
  
  private func addImageView() {
    imageView.contentMode = .scaleAspectFit

    view.addSubview(imageView)
    
    imageView.addEdgeConstraints(exclude: .bottom, offset: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    imageView.bottomAnchor.constraint(equalTo: controllerView.topAnchor, constant: -10).isActive = true
    imageView.addCenterConstraints()
  }
  
  private func addControllerView() {
    view.addSubview(controllerView)
    
    controllerView.translatesAutoresizingMaskIntoConstraints = false
    controllerView.addEdgeConstraints(exclude: .top,offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    controllerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
  }
  
  private func configureBarButtons() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
  }
  
  @objc func didTapClose() {
    dismiss(animated: true, completion: nil)
    getNilPlayer?()
  }
  
  @objc func didTapAction() {
    
  }
  
  var getNilPlayer: (() -> (Void))?
  var getNextViewModel: (() -> (Void))?
  var getPreviousViewModel: (() -> (Void))?

}

extension PlayerViewController: PlayerControlsViewDelegate {
  
  struct ViewModel {
    var songName: String
    var subtitle: String
    var imageURL: String
  }
  
  func PLayerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
    AudioPlayer.shared.changeVolumeWith(value)
  }

  func PLayerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView) {
    AudioPlayer.shared.exchange()
  }
  
  func PLayerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
    AudioPlayer.shared.playNext()
    getNextViewModel?()
  }

  func PLayerControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView) {
    AudioPlayer.shared.playPrevious()
    getPreviousViewModel?()
  }
}
