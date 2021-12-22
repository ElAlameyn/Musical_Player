//
//  UIButton+Extension.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 22.12.2021.
//

import UIKit

extension UIButton {
  func setFor(imageName: String) {
    let image = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(40)))?
      .withTintColor(.white, renderingMode: .alwaysOriginal)
    self.setImage(image, for: .normal)
  }
}
