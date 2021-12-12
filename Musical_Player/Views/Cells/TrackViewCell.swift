import UIKit

class TrackViewCell: UITableViewCell {
  
  let nameLabel = UILabel()
  let subtitle = UILabel()
  let imageTrackView = UIImageView()
  
  var viewModel: PlayerViewController.ViewModel? {
    didSet {
      nameLabel.text = viewModel?.songName
      subtitle.text = viewModel?.subtitle
      if let url = URL(string: viewModel?.imageURL ?? "") {
        imageTrackView.sd_setImage(with: url)
      }
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addNameLabel()
    addImageView()
    addSubtitle()
  }
  
  private func addSubtitle() {
    subtitle.text = "Default"
    subtitle.textAlignment = .left
    subtitle.textColor = .gray
    subtitle.font = .preferredFont(forTextStyle: .callout, compatibleWith: .current)
    subtitle.numberOfLines = 0
    

    contentView.addSubview(subtitle)
    
    subtitle.addEdgeConstraints(exclude: .bottom, .top, offset: UIEdgeInsets(top: 0, left: 80, bottom: -10, right: 0))
    subtitle.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
  }
  
  private func addImageView() {
    contentView.addSubview(imageTrackView)
    
    imageTrackView.translatesAutoresizingMaskIntoConstraints = false
    imageTrackView.layer.cornerRadius = 5
    
    
    imageTrackView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
    imageTrackView.addCenterConstraints(exclude: .axisX)
    imageTrackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    imageTrackView.widthAnchor.constraint(equalToConstant: 50).isActive = true
  }
  
  private func addNameLabel() {
    nameLabel.text = "Default"
    nameLabel.textAlignment = .left
    nameLabel.textColor = .black
    nameLabel.font = .preferredFont(forTextStyle: .body, compatibleWith: .current)
    nameLabel.numberOfLines = 0

    contentView.addSubview(nameLabel)
    
    nameLabel.addEdgeConstraints(exclude: .bottom, offset: UIEdgeInsets(top: 10, left: 80, bottom: 0, right: 0))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
