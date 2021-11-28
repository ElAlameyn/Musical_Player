//
//  SignInViewModel.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 26.11.2021.
//

import Foundation
import UIKit

extension SignInViewController {
  class ViewModel {
    
    var continueButtonTapped: ((Info) -> Void)?
    
    struct Info {
      var email: String
      var password: String
    }
    
    private let cells: [Cells] = [.input(.email), .input(.password), .submitButton]
    
    private(set) var info = Info(email: "", password: "")
    
    
    enum Cells {
      case input(InputCellInfo)
      case submitButton
      
      struct InputCellInfo {
        let placeholder: String
        let isSecure: Bool
        let key: Key
        
        enum Key {
          case email, password
        }
        
        static var email: InputCellInfo {
          InputCellInfo(placeholder: "Email", isSecure: false, key: .email)
        }
        
        static var password: InputCellInfo {
          InputCellInfo(placeholder: "Password", isSecure: true, key: .password)
        }
      }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
      cells.count
    }
    
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
      let cell = getCell(tableView, cellForRowAt: indexPath, of: cells[indexPath.row])
      return cell
    }
    
    private func getCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, of type: Cells) -> UITableViewCell {
      switch type {
      case .input(let cellInfo):
        let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        let value: String
        switch cellInfo.key {
        case .email:
          value = info.email
        case .password:
          value = info.password
        }
        
        cell.fill(placeholder: cellInfo.placeholder, value: value, isSecure: cellInfo.isSecure)
        
        cell.textChanged = { [weak self] text in
          switch cellInfo.key {
          case .email:
            self?.info.email = text
          case .password:
            self?.info.password = text
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
    
  }
}

