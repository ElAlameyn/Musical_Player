//  Musical_Player
//
//  Created by Артем Калинкин on 15.12.2021.
//

import Foundation

struct Validator<T> {
  let run: (String) -> Validated<T>
  
  func compose(_ validators: Validator<T>...) -> Validator<T> {
    Validator<T> { string in
      validators.reduce(run(string)) { (result, validator) -> Validated<T> in
        result.merge(other: validator.run(string))
      }
    }
  }
  
  func map<B>(_ f: @escaping (T) -> B) -> Validator<B> {
    Validator<B> { string in
      let rt = run(string)
      switch rt {
      case .validated( let t):
        return .validated(f(t))
      case .error(let errors):
        return .error(errors)
      }
    }
  }
}

enum Validated<T> {
  case validated(T)
  case error([String])
  
  var getValue: T? {
    switch self {
    case .error: return nil
    case .validated(let t): return t
    }
  }
  
  var getError: [String]? {
    switch self {
    case .error(let errors): return errors
    case .validated: return nil
    }
  }
  
  func merge(other: Validated<T>) -> Validated<T> {
    switch self {
    case .validated:
      switch other {
      case .validated(let valid): return .validated(valid)
      case .error(let error): return .error(error)
      }
    case .error(let errors):
      switch other {
      case .validated: return .error(errors)
      case .error(let errors2): return .error(errors + errors2)
      }
    }
  }
}


extension Validator {
  
  static var emailValidation: Validator<String> {
    Validator<String> { string in
      let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: string) ? .validated(string) : .error(["Incorrect email"])
    }
  }
  
  static var passwordValidation: Validator<String> {
    Validator<String> { string in
      let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
      return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: string) ? .validated(string) : .error(["Incorrect password"])
    }
  }
  
  static var userValidation: Validator<String> {
    Validator<String> { string in
      let regex = "^\\w{7,18}$"
      return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: string) ? .validated(string) : .error(["Incorrect user"])
    }
  }
}
