//
//  MemberView.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 24.11.2021.
//

import UIKit

class MemberView: UIView {

  private var signInButton = UIButton()
  
  init(frame: CGRect, memberText: String, buttonTitle: String) {
    
    super.init(frame: frame)
    

    // Add member label
    let newMemberLabel = UILabel()
    newMemberLabel.textAlignment = .left
    newMemberLabel.textColor = .systemGray3
    newMemberLabel.text = memberText
    
    self.addSubview(newMemberLabel)
    newMemberLabel.addEdgeConstraints(exclude: .right, offset: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    
    signInButton.setTitle(buttonTitle, for: .normal)
    signInButton.setTitleColor(.systemTeal, for: .normal)

    self.addSubview(signInButton)
    signInButton.addEdgeConstraints(exclude: .left, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10))
  }
  
  func addButtonTarget(_ target: Any?, action: Selector) {
    signInButton.addTarget(target, action: action, for: .touchUpInside)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
