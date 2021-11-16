//
//  Constraints+Extension.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 14.11.2021.
//

import UIKit

extension UIView {
  enum AnchorType {
    case top, bottom, right, left
  }
  enum AnchorCenterType {
    case axisX, axisY
  }
  
  func addEdgeConstraints(exclude: AnchorType..., offset: UIEdgeInsets? = nil) {
    guard let superview = superview else {
      fatalError("Must be superview")
    }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if !exclude.contains(.right) {
      rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor, constant: offset?.right ?? 0).isActive = true
    }
    
    if !exclude.contains(.left) {
      leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor, constant: offset?.left ?? 0).isActive = true
    }
    
    if !exclude.contains(.bottom) {
      bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: offset?.bottom ?? 0).isActive = true
    }
    
    if !exclude.contains(.top) {
      topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: offset?.top ?? 0).isActive = true
    }
  }
  
  func addCenterConstraints(exclude: AnchorCenterType..., offset: CGPoint? = nil) {
    
    guard let superview = superview else {
      fatalError("Must be superview")
    }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if !exclude.contains(.axisX) {
      centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset?.x ?? 0).isActive = true
    }
    
    if !exclude.contains(.axisY) {
      centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset?.y ?? 0).isActive = true
    }
  }
}
