//
//  BaseViewController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 15.10.2021.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  
  var tableView = UITableView()
  var tracks = [AudioTrack]()
  
  override func viewDidLoad() {
    view.backgroundColor = .systemBackground
    
    configTableView()
    
    guard let fileURL = Bundle.main.url(forResource: "music", withExtension: "json") else { return }
    guard let data = try? Data(contentsOf: fileURL) else {
      fatalError()
    }
    
    do {
      let trackResponse: AudioTrack = try StorageManager.shared.parse(json: data)
      tracks.append(trackResponse)
    } catch {
      print("Failed to read from file")
    }
    
  }
  
  func configTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(UITableViewCell.self)
    
    view.addSubview(tableView)
    
    tableView.addEdgeConstraints(offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tracks.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(indexPath: indexPath)
    cell.textLabel?.text = tracks[indexPath.row].name
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    PlaybackPresenter.shared.startPlayback(from: self, track: tracks[indexPath.row])
  }
}
