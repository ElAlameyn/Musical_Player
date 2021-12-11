
import SDWebImage
import UIKit

class PlayViewController: UIViewController {
  
  weak var dataSource: PlayerDataSource?
  
  private let controllerView = PlayerControlsView()
  private let imageView = UIImageView()

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
    imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
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

}

extension PlayViewController: PlayerControlsViewDelegate {
  
  func PLayerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView) {
  }
  
  func PLayerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
  }
  
  func PLayerControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView) {
  }

}
