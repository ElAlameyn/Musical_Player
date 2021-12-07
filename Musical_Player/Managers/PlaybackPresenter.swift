//
//  PlaybackPresenter.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 08.12.2021.
//

import Foundation
import UIKit

final class PlaybackPresenter {
  
  static func startPlayback(from viewController: UIViewController, track: AudioTrack) {
    let playerViewController = PlayViewController()
    viewController.present(UINavigationController(rootViewController: playerViewController), animated: true, completion: nil)
  }
}
