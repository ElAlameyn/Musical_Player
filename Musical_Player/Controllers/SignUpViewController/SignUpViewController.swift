//
//  SignUpViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 23.10.2021.
//

import UIKit


class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  enum SignUpCells {
    case userNameInput, emailInput, passwordInput, confirmPasswordInput, submitButton
  }
  
  let validator = Validator()
  
  @IBOutlet var tableView: UITableView!
  
  private let cells: [SignUpCells] = [.userNameInput, .emailInput, .passwordInput, .confirmPasswordInput, .submitButton]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Sign Up"
    
    addMemberView()
    addTableView()

  }

  func addMemberView() {
    let memberView = MemberView(frame: CGRect(), memberText: "Already have an account?", buttonTitle: "Sign In")
    
    memberView.addEdgeConstraints(exclude: .top, offset: UIEdgeInsets(top: 0, left: 10, bottom: -10, right: -10))
    
    memberView.addButtonTarget(self, action: #selector(didPushToSignInTapped))

    view.addSubview(memberView)
  }
  
  func addTableView() {
    tableView.tableHeaderView = HeaderView()

    tableView.registerNib(cellClass: InputCell.self, bundle: .main)
    tableView.registerNib(cellClass: ButtonTableViewCell.self, bundle: .main)

    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
  }

  @objc func didPushToSignInTapped() {
    let signInViewController = SignInViewController()
    navigationController?.pushViewController(signInViewController, animated: true)
  }
  
  
  @objc func signButtonTapped() {
    guard
      let userName = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? InputCell)?.inputTextField.text,
      let email = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? InputCell)?.inputTextField.text,
      let password = (tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? InputCell)?.inputTextField.text
    else { return }
    
    let passwordValid = validator.isValid(password: password)
    let emailValid = validator.isValid(email: email)
    let userNameValid = validator.isValid(userName: userName)
    
    guard passwordValid.isValid else {
      // error
      return
    }
    
    guard emailValid.isValid else {
      // error
      return
    }
    
    guard userNameValid.isValid else {
      // error
      return
    }
    
    StorageManager.shared.saveUserInfo(userName: userName, email: email, password: password)

    let baseViewController = BaseViewController()
    navigationController?.pushViewController(baseViewController, animated: true)
  }
  
  func loginButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = getCell(tableView, cellForRowAt: indexPath, of: cells[indexPath.row])
    if let buttonCell = cell as? ButtonTableViewCell {
      buttonCell.button.addTarget(self, action: #selector(signButtonTapped), for: .touchUpInside)
      return buttonCell
    }
    return cell
  }
  
  func getCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, of type: SignUpCells) -> UITableViewCell {
    switch type {
    case .userNameInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
//      cell.configPlaceHolder(with: "User Name")
      return cell
    case .emailInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
//      cell.configPlaceHolder(with: "Email")
      return cell
    case .passwordInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
//      cell.configPlaceHolder(with: "Password")
      return cell
    case .confirmPasswordInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
//      cell.configPlaceHolder(with: "Confirm Password")
      return cell
    case .submitButton:
      let cell: ButtonTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.buttonTapped = { [weak self] in
        self?.loginButtonTapped()
      }
      return cell
    }
  }
}




