//
//  String+Extension.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 11.11.2021.
//

import Foundation
extension String {

  func isValidEmail() -> Bool {
    // here, `try!` will always succeed because the pattern is valid
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
  }
  
  // Minimum 8 characters at least 1 Alphabet and 1 Number
  func isValidPassword() -> Bool {
      let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
      return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
  }
  
  func isValidUserName() -> Bool {
    let userNameRegex = "^\\w{7,18}$"
    return NSPredicate(format: "SELF MATCHES %@", userNameRegex).evaluate(with: self)
  }
  
}
