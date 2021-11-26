//
//  InputCell.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 15.11.2021.
//

import UIKit

class InputCell: UITableViewCell {
  
  @IBOutlet var inputTextField: UITextField!
  
  var textChanged: ((String) -> Void)?

  func configPlaceHolder(with name: String) {
    if name == "Password" || name == "Confirm Password" {
      inputTextField.isSecureTextEntry = true
    }
    
    inputTextField.placeholder = name
    inputTextField.layer.shadowColor = UIColor.black.cgColor
    inputTextField.layer.shadowRadius = 8
    inputTextField.layer.shadowOpacity = Float(0.05)
    inputTextField.layer.shadowOffset.height = 0.3
    
    inputTextField.addTarget(self, action: #selector(textFieldValueChanged(sender:)), for: .editingChanged)
  }
  
  @objc func textFieldValueChanged(sender: UITextField) {
    textChanged?(sender.text ?? "")
  }

}
