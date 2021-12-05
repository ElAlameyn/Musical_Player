//
//  InputCell.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 15.11.2021.
//

import UIKit

class InputCell: UITableViewCell {
  
  @IBOutlet var inputTextField: UITextField!
  
  enum CellInfo {
  case email, password, confirmPassword, userName
    
    var key: String {
      switch self {
      case .email:
        return "email"
      case .password:
        return "password"
      case .confirmPassword:
        return "confirmPassword"
      case .userName:
        return "userName"
      }
    }
    
    var placeholder: String {
      switch self {
      case .email:
        return "Email"
      case .password:
        return "Password"
      case .confirmPassword:
        return "Confirm password"
      case .userName:
        return "User Name"
      }
    }
    
    var isSecure: Bool {
      switch self {
      case .email:
        return false
      case .password:
        return true
      case .confirmPassword:
        return true
      case .userName:
        return false
      }
    }

  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    inputTextField.layer.shadowColor = UIColor.black.cgColor
    inputTextField.layer.shadowRadius = 8
    inputTextField.layer.shadowOpacity = Float(0.05)
    inputTextField.layer.shadowOffset.height = 0.3
    
    inputTextField.addTarget(self, action: #selector(textFieldValueChanged(sender:)), for: .editingChanged)
  }
  
  var textChanged: ((String) -> Void)?
  
  func fill(info: CellInfo, value: String) {
    inputTextField.placeholder = info.placeholder
    inputTextField.text = value
    inputTextField.isSecureTextEntry = info.isSecure
  }

  @objc func textFieldValueChanged(sender: UITextField) {
    textChanged?(sender.text ?? "")
  }

}
