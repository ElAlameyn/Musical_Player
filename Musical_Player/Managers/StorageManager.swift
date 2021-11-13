//
//  StorageManager.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 11.11.2021.
//

import Foundation

class StorageManager {
  
  enum Const {
    static let userName = "userName"
    static let email = "userEmail"
    static let password = "userPassword"
  }
  
  static let shared = StorageManager()
  
  private init() {}
  
  func saveUserInfo(userName: String, email: String, password: String) {
    UserDefaults.standard.set(userName, forKey: Const.userName)
    UserDefaults.standard.set(email, forKey: Const.email)
    UserDefaults.standard.set(password, forKey: Const.password)
  }
  
  func checkUserInfo(email: String, password: String) -> Bool {
    guard let savedEmail = UserDefaults.standard.string(forKey: Const.email),
          let savedPassword = UserDefaults.standard.string(forKey: Const.password)
    else { return false }
    
    return email == savedEmail && password == savedPassword ? true : false
  }
}
