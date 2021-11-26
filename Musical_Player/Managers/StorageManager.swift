//
//  StorageManager.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 11.11.2021.
//

import Foundation
import KeychainSwift

class StorageManager {
  let keychain = KeychainSwift()
  
  enum Const {
    static let userName = "userName"
    static let email = "userEmail"
    static let password = "userPassword"
    static let token = "token"
  }
  
  static let shared = StorageManager()
  
  private init() {}
  
  func saveUserInfo(userName: String, email: String, password: String) {
    keychain.set(userName, forKey: Const.userName, withAccess: .accessibleWhenUnlocked)
    keychain.set(email, forKey: Const.email, withAccess: .accessibleWhenUnlocked)
    keychain.set(password, forKey: Const.password, withAccess: .accessibleWhenUnlocked)
    
    print("USER NAME: \(String(describing: keychain.get(Const.userName)))")
  }
  
  func checkUserInfo(email: String, password: String) -> Bool {
    guard let savedEmail = keychain.get(Const.email),
          let savedPassword = keychain.get(Const.password)
    else { return false }
    
    return email == savedEmail && password == savedPassword ? true : false
  }
  
  func saveToken(token: String) {
    keychain.set(token, forKey: Const.token, withAccess: .accessibleWhenUnlocked)
  }
  
}
