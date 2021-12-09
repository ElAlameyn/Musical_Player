//
//  SpotifyLoginVC.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 13.11.2021.
//

import UIKit

class SpotifyLoginVC: UIViewController, UITableViewDelegate {
  
  enum Cells {
    case desctiption, submitButton
  }
  
  let cells: [Cells] = [.desctiption, .submitButton]

//  private let submitButton = UIButton(type: .system)
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Spotify Login"
    
    view.backgroundColor = .white

    view.addSubview(tableView)
    
    let image = UIImage(systemName: "music.note.house", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))?
      .withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    let headerImageView = UIImageView(image: image)
    let header = UIView()
      
    header.addSubview(headerImageView)
    
    // Header doesn't support constraints
    header.frame = CGRect(x: 0, y: 0, width: 0, height: 120)

    headerImageView.addEdgeConstraints(exclude: .top , offset: UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0))
    
    tableView.tableHeaderView = header
    headerImageView.contentMode = .center

    tableView.addEdgeConstraints()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self)
  }


}

// MARK: - UITableViewDataSource

extension SpotifyLoginVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch cells[indexPath.row] {
    case .desctiption:
      let cell: UITableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.textLabel?.text = "Enter the Spotify\naccount to use this app"
      cell.textLabel?.textAlignment = .center
      cell.textLabel?.numberOfLines = 0
      cell.textLabel?.font = .preferredFont(forTextStyle: .title2)
      return cell
      
    case .submitButton:
      let cell: UITableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      cell.accessoryView = UIImageView(
        image: UIImage(
          systemName: "chevron.forward.circle",
          withConfiguration: UIImage.SymbolConfiguration(
            font: .preferredFont(forTextStyle: .headline)
          )
        )
      )
      
      cell.accessoryView?.tintColor = .systemTeal
      cell.textLabel?.text = "Log in"
      cell.textLabel?.textColor = .systemTeal

      cell.textLabel?.numberOfLines = 0
      cell.textLabel?.font = .preferredFont(forTextStyle: .headline)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if cells[indexPath.row] == .submitButton {
      let authController = AuthViewController()
      navigationController?.pushViewController(authController, animated: true)
    }
  }
}
  

