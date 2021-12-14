
import UIKit

class ButtonTableViewCell: UITableViewCell {
  
  @IBOutlet var button: UIButton!
  
  var buttonTapped: (() -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let image = UIImage(systemName: Constants.loginButtonImageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?
      .withTintColor(.systemTeal, renderingMode: .alwaysOriginal)

    button.setImage(image, for: .normal)
    button.setTitle("", for: .normal)
    
    button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
  }

  @objc func buttonHandler(sender: UIButton) {
    buttonTapped?()
  }

  
}
