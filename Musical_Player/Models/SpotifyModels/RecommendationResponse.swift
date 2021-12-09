//
//  RecommendationResponse.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 26.11.2021.
//

import Foundation

struct RecommendationResponse: Codable {
  let tracks: [AudioTrack]
}

