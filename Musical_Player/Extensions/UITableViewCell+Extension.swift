//
//  UITableViewCell+Extension.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 09.11.2021.
//

import UIKit

extension UITableView {
  
  enum Cell {
    case userNameInput, emailInput, passwordInput, confirmPasswordInput, submitButton
  }
  
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
  
  func setHeaderView(with image: String, imagePointSize: Int, headerFrameHeight: Int) {
    
    let image = UIImage(systemName: image, withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(imagePointSize)))?
      .withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    let headerImageView = UIImageView(image: image)
    let header = UIView()
      
    header.addSubview(headerImageView)
    
    // Header doesn't support constraints
    header.frame = CGRect(x: 0, y: 0, width: 0, height: headerFrameHeight)
    
    headerImageView.addEdgeConstraints(exclude: AnchorType.top , offset: UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0))
    
    self.tableHeaderView = header
    headerImageView.contentMode = .center

    self.addEdgeConstraints()
  }

  func getCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, of type: UITableView.Cell) -> UITableViewCell {
    switch type {
    case .userNameInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "User Name")
      return cell
    case .emailInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Email")
      return cell
    case .passwordInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Password")
      return cell
    case .confirmPasswordInput:
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.configPlaceHolder(with: "Confirm Password")
      return cell
    case .submitButton:
      let cell: ButtonTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.config()
      return cell
    }
  }

  
}
