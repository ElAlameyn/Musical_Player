//
//  UITableViewCell+Extension.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 09.11.2021.
//

import UIKit

extension UITableView {
  func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T else {
      fatalError("Wrong identifier")
    }
    return cell
  }
  
  
  func register<T: UITableViewCell>(_ cellClass: T.Type) {
    self.register(cellClass, forCellReuseIdentifier: "\(T.self)")
  }
  
  func registerNib<T: UITableViewCell>(cellClass: T.Type, bundle: Bundle) {
    self.register(UINib(nibName:"\(T.self)", bundle: bundle), forCellReuseIdentifier: "\(T.self)")
  }

  
}
