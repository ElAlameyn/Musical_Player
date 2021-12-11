
import SDWebImage
import UIKit


class PlayerViewController: UIViewController {
  
  private let controllerView = PlayerControlsView()
  private let imageView = UIImageView()

  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = .systemBackground
      
      configureBarButtons()
      addControllerView()
      addImageView()
      

      controllerView.delegate = self
    }
  
  public func configure(with viewModel: ViewModel) {
    imageView.sd_setImage(with: URL(string: viewModel.imageURL), completed: nil)
    controllerView.configure(
      with: PlayerControlsView.ViewModel(
        title: viewModel.songName,
        subtitle: viewModel.subtitle))
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
  }
  
  @objc func didTapAction() {
    
  }
  
  var forward: (() -> (Void))?
  var backward: (() -> (Void))?

}

extension PlayerViewController: PlayerControlsViewDelegate {
  
  struct ViewModel {
    var songName: String
    var subtitle: String
    var imageURL: String
  }
  
  func PLayerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
  }

  func PLayerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView) {
    AudioPlayer.shared.exchange()
  }
  
  func PLayerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
    forward?()
  }
  
  func PLayerControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView) {
    backward?()
  }

}
