//
//  ViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 09.10.2021.
//

import UIKit

class LoginViewController: UIViewController, CALayerDelegate {
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!

  var isRegistering = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func continueButtonTapped(_ sender: Any) {
    guard let password = passwordTextField.text, let email = emailTextField.text else { return }
    
    if isRegistering {
      UserDefaults.standard.set(password, forKey: "userPassword")
      UserDefaults.standard.set(email, forKey: "userEmail")
    } else {
      if let userDefPassword = UserDefaults.standard.string(forKey: "userPassword"), let userDefEmail = UserDefaults.standard.string(forKey: "userEmail") {
        if password == userDefPassword && email == userDefEmail {
          print("Login succeeded")
        } else {
          print("Login failed")
        }
      }
    }
  }
  
  @IBAction func signButtonTapped(_ sender: UIButton) {
    if sender.titleLabel?.text == "Sign up" {
      isRegistering = true
      sender.setTitle("Log in", for: .normal)
    } else {
      isRegistering = false
      sender.setTitle("Sign up", for: .normal)
    }
  }
}
