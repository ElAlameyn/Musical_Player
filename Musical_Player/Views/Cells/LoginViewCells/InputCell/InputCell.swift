
import UIKit

class InputCell: UITableViewCell {
  
  @IBOutlet var inputTextField: UITextField!
  
  var isValid: ((String) -> ValidatorError)?
  
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
    
    var isValid: (String) -> ValidatorError {
      switch self {
      case .email:
        return Validator.shared.isValid(email:)
      case .password:
        return Validator.shared.isValid(password:)
      case .confirmPassword:
        return Validator.shared.isValid(password:)
      case .userName:
        return Validator.shared.isValid(userName:)
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
  
  func fill(info: CellInfo) {
    inputTextField.placeholder = info.placeholder
    inputTextField.isSecureTextEntry = info.isSecure
    self.isValid = info.isValid
  }

  @objc func textFieldValueChanged(sender: UITextField) {
    textChanged?(sender.text ?? "")
    
    guard let text = sender.text else { return }
    guard let valid = isValid?(text).isValid else { return }
    
    if valid {
      backgroundColor = .green
    } else {
      backgroundColor = .red
    }
  }

}

