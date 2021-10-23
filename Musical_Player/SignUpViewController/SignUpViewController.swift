//
//  SignUpViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 23.10.2021.
//

import UIKit

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
    
    UserDefaults.standard.set(userName, forKey: "userName")
    UserDefaults.standard.set(email, forKey: "userEmail")
    UserDefaults.standard.set(password, forKey: "userPassword")
    
    print("Login succeded")

  }
  @IBAction func loginButtonTapped(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
}
