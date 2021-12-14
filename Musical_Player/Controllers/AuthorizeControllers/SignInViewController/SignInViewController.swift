//
//  ViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 09.10.2021.
//

import UIKit

class SignInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  let viewModel = ViewModel()

  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = Localizable.singInTitle
    
    configTableView()
    addMemberView()

    viewModel.continueButtonTapped = { [weak self] info in
      self?.continueButtonTapped(info: info)
    }
  }
  
  func addMemberView() {
    let memberView = MemberView(frame: CGRect(),
                                memberText: Localizable.memberViewText,
                                buttonTitle: Localizable.singUpTitle)
    view.addSubview(memberView)
    memberView.addEdgeConstraints(exclude: .top, offset: UIEdgeInsets(top: 0, left: 10, bottom: -10, right: -10))
    memberView.addButtonTarget(self, action: #selector(didPushToSignUpTapped(_:)))
  }
  
  func configTableView() {
    tableView.tableHeaderView = LoginHeaderView()

    tableView.registerNib(cellClass: InputCell.self, bundle: .main)
    tableView.registerNib(cellClass: ButtonTableViewCell.self, bundle: .main)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    viewModel.cellForRowAt(tableView: tableView, indexPath: indexPath)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.numberOfRowsInSection(section: section)
  }
  
  @IBAction func didPushToSignUpTapped(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }

  func continueButtonTapped(info: ViewModel.Info) {

    if StorageManager.shared.checkUserInfo(email: info.email, password: info.password) {
      let baseViewController = BaseViewController()
      navigationController?.pushViewController(baseViewController, animated: true)
    } else {
      return
    }
  }
  
}








