
import Foundation

struct TokenResponse: Codable {
  let access_token: String
  let expires_in: Int
  let refresh_token: String?
  let token_type: String
}
