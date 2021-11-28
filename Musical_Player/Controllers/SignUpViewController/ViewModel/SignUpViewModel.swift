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
    
    struct Info {
      var userName: String
      var email: String
      var password: String
      var confirmPassword: String
    }
    
    private let cells: [Cells] = [.input(.userName), .input(.email), .input(.password), .input(.confirmPassword), .submitButton]
    
    private(set) var info = Info(userName: "", email: "", password: "", confirmPassword: "")
    
    enum Cells {
      case input(InputCellInfo)
      case submitButton
      
      struct InputCellInfo {
        let placeholder: String
        let isSecure: Bool
        let key: Key
        
        enum Key {
          case email, password, userName, confirmPassword
        }
        
        static var confirmPassword: InputCellInfo {
          InputCellInfo(placeholder: "ConfirmPassword", isSecure: true, key: .confirmPassword)
        }
        
        static var userName: InputCellInfo {
          InputCellInfo(placeholder: "UserName", isSecure: false, key: .userName)
        }
        
        static var email: InputCellInfo {
          InputCellInfo(placeholder: "Email", isSecure: false, key: .email)
        }
        
        static var password: InputCellInfo {
          InputCellInfo(placeholder: "Password", isSecure: true, key: .password)
        }
      }
    }
    
    
    func getCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, of type: Cells) -> UITableViewCell {
      switch type {
      case .input(let cellInfo):
        let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        let value: String
        
        switch cellInfo.key {
        case .email:
          value = info.email
        case .password:
          value = info.password
        case .userName:
          value = info.userName
        case .confirmPassword:
          value = info.confirmPassword
        }
        
        cell.fill(placeholder: cellInfo.placeholder, value: value, isSecure: cellInfo.isSecure)
        
        cell.textChanged = { [weak self] text in
          switch cellInfo.key {
          case .email:
            self?.info.email = text
          case .password:
            self?.info.password = text
          case .userName:
            self?.info.userName = text
          case .confirmPassword:
            self?.info.confirmPassword = text
          }
        }
        
        return cell
        
      case .submitButton:
        let cell: ButtonTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.buttonTapped = { [unowned self] in
          self.continueButtonTapped?(self.info)
        }
        return cell
      }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
      cells.count
    }
    
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
      let cell = getCell(tableView, cellForRowAt: indexPath, of: cells[indexPath.row])
      return cell
    }

  }
}
