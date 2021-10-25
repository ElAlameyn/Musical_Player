//
//  BaseViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 15.10.2021.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Coffee player"
    label.font = .preferredFont(forTextStyle: .title1)
    label.textColor = .black
    return label
  }()
 
  override func viewDidLoad() {
    view.backgroundColor = .white

    view.addSubview(titleLabel)
   
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 41).isActive = true
  }
}
