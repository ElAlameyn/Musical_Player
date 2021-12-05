//
//  TokenResponse.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 26.11.2021.
//

import Foundation

struct TokenResponse: Codable {
  let access_token: String
  let expires_in: Int
  let refresh_token: String?
  let token_type: String
}
