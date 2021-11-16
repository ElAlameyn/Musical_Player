//
//  UIViewController+Extension.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 16.11.2021.
//

import UIKit

extension UIViewController {
  
  func addMemberView(memberLabelText: String, buttonTitle: String) -> UIButton {
    let memberView = UIView()

    view.addSubview(memberView)
    memberView.addEdgeConstraints(exclude: .top, offset: UIEdgeInsets(top: 0, left: 10, bottom: -10, right: -10))

    // Add member label
    let newMemberLabel = UILabel()
    newMemberLabel.textAlignment = .left
    newMemberLabel.textColor = .systemGray3
    newMemberLabel.text = memberLabelText
    
    memberView.addSubview(newMemberLabel)
    newMemberLabel.addEdgeConstraints(exclude: .right, offset: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    
    let signInButton = UIButton()
    signInButton.setTitle(buttonTitle, for: .normal)
    signInButton.setTitleColor(.systemTeal, for: .normal)

    memberView.addSubview(signInButton)
    signInButton.addEdgeConstraints(exclude: .left, offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10))
    
    return signInButton
  }
}
