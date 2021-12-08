//
//  PlayViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 08.12.2021.
//

import UIKit

class PlayViewController: UIViewController {
  
  private let controllerView = PLayerControlsView()
  private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = .systemBackground
      configureBarButtons()
      addControllerView()
      addImageView()
    }
  
  private func addImageView() {
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .systemBlue
    
    view.addSubview(imageView)
    
    imageView.addEdgeConstraints(exclude: .bottom, offset: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    imageView.bottomAnchor.constraint(equalTo: controllerView.topAnchor, constant: -10).isActive = true
    imageView.addCenterConstraints()
  }
  
  private func addControllerView() {
    view.addSubview(controllerView)
    
    controllerView.translatesAutoresizingMaskIntoConstraints = false
    controllerView.addEdgeConstraints(exclude: .top, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    controllerView.heightAnchor.constraint(equalToConstant: 170).isActive = true
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
