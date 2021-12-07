//
//  PlayViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 08.12.2021.
//

import UIKit

class PlayViewController: UIViewController {
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .systemBlue
    return imageView
  }()
  
  private let controllerView = PLayerControlsView()

    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = .systemBackground
      configureBarButtons()
      
      view.addSubview(imageView)
      view.addSubview(controllerView)
      
      imageView.addEdgeConstraints(exclude: .bottom, offset: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
      imageView.addCenterConstraints()
      
      controllerView.translatesAutoresizingMaskIntoConstraints = false
      controllerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
      controllerView.addEdgeConstraints(exclude: .top, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
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
