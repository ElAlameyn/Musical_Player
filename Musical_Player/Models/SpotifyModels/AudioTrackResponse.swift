
import Foundation

struct AudioTrack: Codable, Equatable {
  
  static func == (lhs: AudioTrack, rhs: AudioTrack) -> Bool {
    lhs.id == rhs.id
  }
  
  let album: Album?
  let artists: [Artist]
  let available_markets: [String]
  let disc_number: Int
  let duration_ms: Int
  let explicit: Bool
  let external_urls: [String: String]
  let id: String
  let name: String
  let preview_url: String?
}
