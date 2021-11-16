//
//  InputCell.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 15.11.2021.
//

import UIKit

class InputCell: UITableViewCell {
  
  @IBOutlet var inputTextField: UITextField!
  
  
  func configPlaceHolder(with name: String) {
    inputTextField.placeholder = name
    inputTextField.layer.shadowColor = UIColor.black.cgColor
    inputTextField.layer.shadowRadius = 8
    inputTextField.layer.shadowOpacity = Float(0.05)
    inputTextField.layer.shadowOffset.height = 0.3
  }
}
