
import Foundation

class Validator {
  
  static let shared = Validator()
  
  func isValid(email: String) -> ValidatorError {
    
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email) {
      return ValidatorError(isValid: true, errorInfo: nil)
    } else {
      return ValidatorError(isValid: false, errorInfo: "Email is not valid")
    }
  }
  
  // Minimum 8 characters at least 1 Alphabet and 1 Number
  func isValid(password: String) -> ValidatorError {
    
    let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    
    if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password) {
      return ValidatorError(isValid: true, errorInfo: nil)
    } else {
      return ValidatorError(isValid: false, errorInfo: "Email is not valid")
    }
  }
  
  func isValid(userName: String) -> ValidatorError {
    
    let regex = "^\\w{7,18}$"
    
    if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: userName) {
      return ValidatorError(isValid: true, errorInfo: nil)
    } else {
      return ValidatorError(isValid: false, errorInfo: "Email is not valid")
    }
  }
}
