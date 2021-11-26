//
//  InputCell.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 15.11.2021.
//

import UIKit

class InputCell: UITableViewCell {
  
  @IBOutlet var inputTextField: UITextField!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    inputTextField.layer.shadowColor = UIColor.black.cgColor
    inputTextField.layer.shadowRadius = 8
    inputTextField.layer.shadowOpacity = Float(0.05)
    inputTextField.layer.shadowOffset.height = 0.3
    
    inputTextField.addTarget(self, action: #selector(textFieldValueChanged(sender:)), for: .editingChanged)
  }
  
  var textChanged: ((String) -> Void)?
  
  func fill(placeholder: String, value: String, isSecure: Bool) {
    inputTextField.placeholder = placeholder
    inputTextField.text = value
    inputTextField.isSecureTextEntry = isSecure
  }

  @objc func textFieldValueChanged(sender: UITextField) {
    textChanged?(sender.text ?? "")
  }

}
