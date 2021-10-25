//
//  SignUpViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 23.10.2021.
//

import UIKit

enum Const {
  static let userName = "userName"
  static let email = "userEmail"
  static let password = "userPassword"
}

class SignUpViewController: UIViewController {
  @IBOutlet var userNameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var confirmPasswordField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  @IBAction func signButtonTapped(_ sender: Any) {
    guard let userName = userNameTextField.text,
          let email = emailTextField.text,
          let password = passwordTextField.text,
          passwordTextField.text == confirmPasswordField.text else {
           print("Login failed")
            return
          }
    
    if email.isValidEmail() && password.isValidPassword() && userName.isValidUserName() {
      UserDefaults.standard.set(userName, forKey: Const.userName)
      UserDefaults.standard.set(email, forKey: Const.email)
      UserDefaults.standard.set(password, forKey: Const.password)
      print("Login succeded")
      
      let vc = BaseViewController()
      navigationController?.pushViewController(vc, animated: true)
    } else {
      print("login failed")
    }
  }
  
  @IBAction func loginButtonTapped(_ sender: Any) {
    userNameTextField.text = ""
    emailTextField.text = ""
    confirmPasswordField.text = ""
    
    navigationController?.popViewController(animated: true)
  }
  
}

extension String {

  func isValidEmail() -> Bool {
    // here, `try!` will always succeed because the pattern is valid
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  // Minimum 8 characters at least 1 Alphabet and 1 Number
  func isValidPassword() -> Bool {
      let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
      return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
  }
  
  func isValidUserName() -> Bool {
    let userNameRegex = "^\\w{7,18}$"
    return NSPredicate(format: "SELF MATCHES %@", userNameRegex).evaluate(with: self)
  }
  
}

