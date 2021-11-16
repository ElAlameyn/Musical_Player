//
//  ButtonTableViewCell.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 15.11.2021.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
  @IBOutlet var button: UIButton!
  
  func config() {
    let image = UIImage(systemName: "chevron.right.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?
      .withTintColor(.systemTeal, renderingMode: .alwaysOriginal)

    button.setImage(image, for: .normal)
    button.setTitle("", for: .normal)
  }
}
