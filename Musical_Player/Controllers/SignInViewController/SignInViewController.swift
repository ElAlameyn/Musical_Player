//
//  ViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 09.10.2021.
//

import UIKit


class SignInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  private let cells: [UITableView.Cell] = [.emailInput, .passwordInput, .submitButton]

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
    let cell = tableView.getCell(tableView, cellForRowAt: indexPath, of: cells[indexPath.row])
    if let buttonCell = cell as? ButtonTableViewCell {
      buttonCell.button.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
      return buttonCell
    }
    return cell
    
  }
  

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cells.count
  }
  
  @IBAction func didPushToSignUpTapped(_ sender: UIButton) {
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







