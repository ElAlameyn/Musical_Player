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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func continueButtonTapped(_ sender: Any) {
    guard let password = passwordTextField.text, let email = emailTextField.text else { return }
    if let userDefPassword = UserDefaults.standard.string(forKey: Const.password), let userDefEmail = UserDefaults.standard.string(forKey: Const.email) {
      if password == userDefPassword && email == userDefEmail {
        print("Login succeeded")
        let vc = BaseViewController()
        navigationController?.pushViewController(vc, animated: true)
      } else {
        print("Login failed")
      }
    }
  }
  
  
  @IBAction func signButtonTapped(_ sender: UIButton) {
    passwordTextField.text = ""
    emailTextField.text = ""
    
    let vc = SignUpViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}

