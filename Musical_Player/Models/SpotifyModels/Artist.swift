//
//  Artis.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 26.11.2021.
//

import Foundation

struct Artist: Codable {
  let id: String
  let name: String
  let type: String
  let external_urls: [String: String]
}
