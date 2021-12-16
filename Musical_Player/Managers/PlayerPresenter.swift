//
//  PlayerPresenter.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 16.12.2021.
//

import Foundation

final class PlayerPresenter {
  
  var playerViewController: PlayerViewController?
  
  init(with track: AudioTrack) {
    playerViewController = PlayerViewController()
    playerViewController?.title = track.name
    
    playerViewController?.getNextViewModel = {
      self.playerViewController?.title = track.name
      guard let track = AudioPlayer.shared.track else { return }
      self.configurePlayerViewModel(with: track)
    }
    
    playerViewController?.getPreviousViewModel = {
      self.playerViewController?.title = track.name
      guard let track = AudioPlayer.shared.track else { return }
      self.configurePlayerViewModel(with: track)
    }
    
    playerViewController?.getNilPlayer = {
      self.playerViewController = nil
    }
    
    configurePlayerViewModel(with: track)
  }
  
  private func configurePlayerViewModel(with track: AudioTrack) {
    playerViewController?.viewModel = PlayerViewController.ViewModel(
      songName: track.name,
      subtitle: track.artists.first?.name ?? "",
      imageURL: track.album?.images.first?.url ?? "")
  }
}
