
import UIKit

class BaseHeaderView: UIView {
  
  let button = UIButton()
  let title = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.frame = CGRect(x: 0, y: 0, width: 0, height: 50)

    addButton()
    addTitle()
  }
  
  private func addTitle() {
    title.text = "Featured"
    title.textColor = .systemTeal
    title.textAlignment = .left
    title.numberOfLines = 0
    title.font = .preferredFont(forTextStyle: .title1, compatibleWith: .current)
    
    self.addSubview(title)
    
    title.translatesAutoresizingMaskIntoConstraints = false
    title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
    title.addCenterConstraints(exclude: .axisX)
  }
  
  private func addButton() {
    let image = UIImage(systemName: Constants.mainScreenHeaderViewPlayButton, withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(30)))?
      .withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    
    button.setImage(image, for: .normal)
    button.setTitle("", for: .normal)

    self.addSubview(button)

    button.translatesAutoresizingMaskIntoConstraints = false
    button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    button.addCenterConstraints(exclude: .axisX)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
