//
//  ViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 09.10.2021.
//

import UIKit


class LoginViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  private let cells: [Cell] = [.title, .emailInput, .passwordInput, .button]

  enum Cell {
    case title, emailInput, passwordInput, button
  }
  
  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

    tableView.registerNib(cellClass: TitleCell.self, bundle: .main)
    tableView.registerNib(cellClass: InputCell.self, bundle: .main)
    tableView.registerNib(cellClass: ButtonCell.self, bundle: .main)

    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch cells[indexPath.row] {
    case .title:
      let cell: TitleCell = tableView.dequeueReusableCell(indexPath: indexPath)
      return cell
    case .emailInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Email")
      return cell
    case .passwordInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Password")
      return cell
    case .button:
      let cell: ButtonCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cells.count
  }
  

  @objc func continueButtonTapped(_ sender: Any) {
    guard
      let email = (tableView.cellForRow(at: IndexPath(row: 1, section: 0))
                   as? InputCell)?.getValue(),
      let password = (tableView.cellForRow(at: IndexPath(row: 2, section: 0))
                      as? InputCell)?.getValue()
    else { return }
    

    if StorageManager.shared.checkUserInfo(email: email, password: password) {
      let baseViewController = BaseViewController()
      navigationController?.pushViewController(baseViewController, animated: true)
    } else {
      return
    }
  }
  
}




//  @IBAction func signButtonTapped(_ sender: UIButton) {
////    passwordTextField.text = ""
////    emailTextField.text = ""
//
//    let vc = SignUpViewController()
//    navigationController?.pushViewController(vc, animated: true)
//  }


