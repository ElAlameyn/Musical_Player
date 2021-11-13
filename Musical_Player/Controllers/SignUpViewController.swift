//
//  SignUpViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 23.10.2021.
//

import UIKit


class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  enum Cell {
    case title, userNameInput, emailInput, passwordInput, confirmPasswordInput,button
  }
  
  @IBOutlet var tableView: UITableView!
  
  private let cells: [Cell] = [.title, .userNameInput, .emailInput, .passwordInput, .confirmPasswordInput, .button]
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let memberView = UIView()
    memberView.backgroundColor = .red
    
    view.addSubview(memberView)
    
    memberView.translatesAutoresizingMaskIntoConstraints = false
    memberView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
    memberView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
    memberView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    memberView.heightAnchor.constraint(equalToConstant: 30).isActive = true

    tableView.registerNib(cellClass: TitleCell.self, bundle: .main)
    tableView.registerNib(cellClass: InputCell.self, bundle: .main)
    tableView.registerNib(cellClass: ButtonCell.self, bundle: .main)

    tableView.delegate = self
    tableView.dataSource = self
    // Do any additional setup after loading the view.
  }
  
  @objc func signButtonTapped(_ sender: Any) {
    guard
      let userName = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? InputCell)?.getValue(),
      let email = (tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? InputCell)?.getValue(),
      let password = (tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? InputCell)?.getValue()
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
    switch cells[indexPath.row] {
    case .title:
      let cell: TitleCell = tableView.dequeueReusableCell(indexPath: indexPath)
      return cell
    case .userNameInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "User Name")
      return cell
    case .emailInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Email")
      return cell
    case .passwordInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Password")
      return cell
    case .confirmPasswordInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Confirm Password")
      return cell
    case .button:
      let cell: ButtonCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.button.addTarget(self, action: #selector(signButtonTapped), for: .touchUpInside)
      return cell
    }
  }
  
}



