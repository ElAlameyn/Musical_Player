//
//  ViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 09.10.2021.
//

import UIKit


class SignInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  private let cells: [Cell] = [.emailInput, .passwordInput, .submitButton]

  enum Cell {
    case emailInput, passwordInput, submitButton
  }
  
  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Sign In"

    tableView.registerNib(cellClass: InputCell.self, bundle: .main)
    tableView.registerNib(cellClass: ButtonTableViewCell.self, bundle: .main)

    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.setHeaderView(with: "music.note", imagePointSize: 60, headerFrameHeight: 80)
    
    addMemberView(memberLabelText: "New member?", buttonTitle: "Sign Up").addTarget(self, action: #selector(didPushToSignUpTapped), for: .touchUpInside)
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    getCell(tableView, at: indexPath)
  }
  
  func getCell(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    switch cells[indexPath.row] {
    case .emailInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Email")
      return cell
    case .passwordInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Password")
      return cell
    case .submitButton:
      let cell: ButtonTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.config()
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cells.count
  }
  
  @IBAction func didPushToSignUpTapped(_ sender: UIButton) {

    
    let signUpViewController = SignUpViewController()
    navigationController?.popViewController(animated: true)
  }

  @objc func continueButtonTapped(_ sender: Any) {
    guard
      let email = (tableView.cellForRow(at: IndexPath(row: 1, section: 0))
                   as? InputCell)?.inputTextField.text,
      let password = (tableView.cellForRow(at: IndexPath(row: 2, section: 0))
                      as? InputCell)?.inputTextField.text
    else { return }
    

    if StorageManager.shared.checkUserInfo(email: email, password: password) {
      let baseViewController = BaseViewController()
      navigationController?.pushViewController(baseViewController, animated: true)
    } else {
      return
    }
  }
  
}







