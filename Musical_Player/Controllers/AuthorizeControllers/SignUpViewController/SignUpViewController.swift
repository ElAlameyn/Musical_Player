//
//  SignUpViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 23.10.2021.
//

import UIKit


class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let viewModel = ViewModel()

  @IBOutlet var tableView: UITableView!
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Sign Up"
    
    addMemberView()
    configTableView()

    viewModel.continueButtonTapped = { [weak self] info in
      self?.continueButtonTapped(info: info)
    }
  }

  func addMemberView() {
    let memberView = MemberView(frame: CGRect(), memberText: "Already have an account?", buttonTitle: "Sign In")
    view.addSubview(memberView)
    memberView.addEdgeConstraints(exclude: .top, offset: UIEdgeInsets(top: 0, left: 10, bottom: -10, right: -10))
    memberView.addButtonTarget(self, action: #selector(didPushToSignInTapped))
  }
  
  func configTableView() {
    tableView.tableHeaderView = LoginHeaderView()

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
  
  
  func continueButtonTapped(info: ViewModel.Info) {
    
    guard info.password == info.confirmPassword else { return }

    StorageManager.shared.saveUserInfo(userName: info.userName, email: info.email, password: info.password)

    let baseViewController = BaseViewController()
    navigationController?.pushViewController(baseViewController, animated: true)
  }
  
  func loginButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.numberOfRowsInSection(section: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    viewModel.cellForRowAt(tableView: tableView, indexPath: indexPath)
  }
}




