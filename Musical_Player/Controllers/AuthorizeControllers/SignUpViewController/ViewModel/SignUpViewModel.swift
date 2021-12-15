//
//  SignUpViewModel.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 27.11.2021.
//

import UIKit

extension SignUpViewController {
  class ViewModel {
    
    var continueButtonTapped: ((Info) -> Void)?
    
    class Info: NSObject {
      @objc var userName: String
      @objc var email: String
      @objc var password: String
      @objc var confirmPassword: String

      init(userName: String, email: String, password: String, confirmPassword: String) {
        self.userName = userName
        self.confirmPassword = confirmPassword
        self.email = email
        self.password = password
      }
    }
    
    private(set) var info = Info(userName: "", email: "", password: "", confirmPassword: "")

    private var cellWrappers: [CellWrapper] = []
    
    init() {
      cellWrappers = [
        .inputCell(cellInfo: .userName, output: { [weak self] text, key in
          self?.info.setValue(text, forKey: key)
        }),
        .inputCell(cellInfo: .email, output: { [weak self] text, key in
          self?.info.setValue(text, forKey: key)
        }),
        .inputCell(cellInfo: .password, output: { [weak self] text, key in
          self?.info.setValue(text, forKey: key)
        }),
        .inputCell(cellInfo: .confirmPassword, output: { [weak self] text, key in
          self?.info.setValue(text, forKey: key)
        }),
        .logInButton(output: { [unowned self] in
          self.continueButtonTapped?(self.info)
        })
      ]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
      cellWrappers.count
    }
    
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
      let cell = cellWrappers[indexPath.row].cell(tableView, indexPath, info)
      return cell
    }
  }
}
