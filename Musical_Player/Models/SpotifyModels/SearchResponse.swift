
import Foundation

struct SearchResponse: Codable {
  var tracks: Items
  
  struct Items: Codable {
    var items: [AudioTrack]
  }
}

