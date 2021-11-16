//
//  SignUpViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 23.10.2021.
//

import UIKit


class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  enum Cell {
    case userNameInput, emailInput, passwordInput, confirmPasswordInput, submitButton
  }
  
  @IBOutlet var tableView: UITableView!
  
  private let cells: [UITableView.Cell] = [.userNameInput, .emailInput, .passwordInput, .confirmPasswordInput, .submitButton]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Sign Up"


    tableView.registerNib(cellClass: InputCell.self, bundle: .main)
    tableView.registerNib(cellClass: ButtonTableViewCell.self, bundle: .main)

    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.setHeaderView(with: "music.note", imagePointSize: 60, headerFrameHeight: 100)
    
    addMemberView(memberLabelText: "Already have an account?", buttonTitle: "Sign In").addTarget(self, action: #selector(didPushToSignInTapped), for: .touchUpInside)

  }
  

  @objc func didPushToSignInTapped() {
    let signInViewController = SignInViewController()
    navigationController?.pushViewController(signInViewController, animated: true)
  }
  
  
  @objc func signButtonTapped(_ sender: Any) {
    guard
      let userName = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? InputCell)?.inputTextField.text,
      let email = (tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? InputCell)?.inputTextField.text,
      let password = (tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? InputCell)?.inputTextField.text
    else { return }

    if email.isValidEmail() && password.isValidPassword() && userName.isValidUserName() {
      StorageManager.shared.saveUserInfo(userName: userName, email: email, password: password)
      print("Registration succeeded")
      
      let baseViewController = BaseViewController()
      navigationController?.pushViewController(baseViewController, animated: true)
    } else {
      print("registration failed")
    }
  }
  
  @IBAction func loginButtonTapped(_ sender: Any) {
    //    userNameTextField.text = ""
    //    emailTextField.text = ""
    //    confirmPasswordField.text = ""
    
    navigationController?.popViewController(animated: true)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.getCell(tableView, cellForRowAt: indexPath, of: cells[indexPath.row])
    if let buttonCell = cell as? ButtonTableViewCell {
      buttonCell.button.addTarget(self, action: #selector(signButtonTapped(_:)), for: .touchUpInside)
      return buttonCell
    }
    return cell
  }
}




