//
//  ButtonTableViewCell.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 15.11.2021.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
  
  @IBOutlet var button: UIButton!
  
  var buttonTapped: (() -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let image = UIImage(systemName: "chevron.right.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?
      .withTintColor(.systemTeal, renderingMode: .alwaysOriginal)

    button.setImage(image, for: .normal)
    button.setTitle("", for: .normal)
    
    button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
  }

  @objc func buttonHandler(sender: UIButton) {
    buttonTapped?()
  }

  
  func addButtonTarget(_ target: Any?, action: Selector) {
    button.addTarget(target, action: action, for: .touchUpInside)
  }
  
}
