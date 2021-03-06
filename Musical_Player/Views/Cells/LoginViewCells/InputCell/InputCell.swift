
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
    
    var validator: Validator<String> {
      switch self {
      case .email:
        return .emailValidation
      case .password:
        return .passwordValidation
      case .confirmPassword:
        return .passwordValidation
      case .userName:
        return .userValidation
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
    
//    let imageView = UIImageView(image: UIImage(systemName: "xmark"))
//    let view = UIView()
//    view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//    view.backgroundColor = .blue
//    inputTextField.leftView = view
  }
  
  var textChanged: ((String) -> Void)?
  
  func fill(info: CellInfo) {
    inputTextField.placeholder = info.placeholder
    inputTextField.isSecureTextEntry = info.isSecure
  }

  @objc func textFieldValueChanged(sender: UITextField) {
    textChanged?(sender.text ?? "")
  }
}

