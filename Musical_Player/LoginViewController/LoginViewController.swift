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
      if let userDefPassword = UserDefaults.standard.string(forKey: "userPassword"), let userDefEmail = UserDefaults.standard.string(forKey: "userEmail") {
        if password == userDefPassword && email == userDefEmail {
          print("Login succeeded")
        } else {
          print("Login failed")
        }
      }
    }

  
  @IBAction func signButtonTapped(_ sender: UIButton) {
    let vc = SignUpViewController()
//    vc.presentationController?.shouldPresentInFullscreen
    navigationController?.pushViewController(vc, animated: true)
  }
}
