//
//  ViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 09.10.2021.
//

import UIKit



class SignInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  struct Info {
    var email: String
    var password: String
  }

  private let cells: [SignInCells] = [.emailInput, .passwordInput, .submitButton]
  private var info = Info(email: "", password: "")

  enum SignInCells {
    case emailInput, passwordInput, submitButton
  }
  
  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Sign In"
    
    addTableView()
    addMemberView()

  }
  
  func addMemberView() {
    let memberView = MemberView(frame: CGRect(), memberText: "New member?", buttonTitle: "Sign Up")
    view.addSubview(memberView)
    memberView.addEdgeConstraints(exclude: .top, offset: UIEdgeInsets(top: 0, left: 10, bottom: -10, right: -10))
    memberView.addButtonTarget(self, action: #selector(didPushToSignUpTapped(_:)))
  }
  
  func addTableView() {
    tableView.tableHeaderView = HeaderView()

    tableView.registerNib(cellClass: InputCell.self, bundle: .main)
    tableView.registerNib(cellClass: ButtonTableViewCell.self, bundle: .main)

    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = getCell(tableView, cellForRowAt: indexPath, of: cells[indexPath.row])
    return cell
  }
  
  func getCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, of type: SignInCells) -> UITableViewCell {
    switch type {
    case .emailInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Email")
      cell.textChanged = { [weak self] text in
        self?.info.email = text
      }
      return cell
    case .passwordInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Password")
      cell.textChanged = { [weak self] text in
        self?.info.password = text
      }
      return cell
    case .submitButton:
      let cell: ButtonTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.buttonTapped = { [weak self] in
        self?.continueButtonTapped()
      }
      return cell
    }
  }
  

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cells.count
  }
  
  @IBAction func didPushToSignUpTapped(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }

  func continueButtonTapped() {

    if StorageManager.shared.checkUserInfo(email: info.email, password: info.password) {
      let baseViewController = BaseViewController()
      navigationController?.pushViewController(baseViewController, animated: true)
    } else {
      return
    }
  }
  
}







