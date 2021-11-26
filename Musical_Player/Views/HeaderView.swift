//
//  HeaderView.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 24.11.2021.
//

import UIKit

class HeaderView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let image = UIImage(systemName: "music.note", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(60)))?
      .withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    let headerImageView = UIImageView(image: image)

    self.addSubview(headerImageView)
    
    // Header doesn't support constraints
    self.frame = CGRect(x: 0, y: 0, width: 0, height: 80)
    
    headerImageView.addEdgeConstraints(exclude: AnchorType.top , offset: UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0))
    
    headerImageView.contentMode = .center

//    self.addEdgeConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
