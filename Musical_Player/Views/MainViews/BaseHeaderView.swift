
import UIKit

class BaseHeaderView: UIView {
  
  let title = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.frame = CGRect(x: 0, y: 0, width: 0, height: 40)

    addTitle()
  }
  
  private func addTitle() {
    title.text = "Featured"
    title.textColor = .systemGray
    title.textAlignment = .left
    title.numberOfLines = 0
    title.font = .preferredFont(forTextStyle: .callout, compatibleWith: .current)
    
    self.addSubview(title)
    
    title.translatesAutoresizingMaskIntoConstraints = false
    title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
    title.addCenterConstraints(exclude: .axisX)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
