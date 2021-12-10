//
//  SpoifyAPI.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 17.11.2021.
//

import Foundation
import Combine
import CoreText

class SpotifyAPI {
  
  static let shared = SpotifyAPI()
  var subscriber: AnyCancellable?

  enum Const {
    static let baseAPIURL = "https://api.spotify.com/v1"
    
    static let recommendedGenres = "/recommendations/available-genre-seeds"
    static let recommendations = "/recommendations?limit=40"
  }
  

  enum ApiError: Error {
    case error(Error)
    case urlError
    case responseError
  }

  func getToken(with code: String, url: URL) -> AnyPublisher<TokenResponse, Error> {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // Set HTTP headers
    request.setValue("Basic \("\(AuthViewController.Const.clientID):\(AuthViewController.Const.clientServer)".toBase64())", forHTTPHeaderField: "Authorization")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    // Set request body parameters
    var components = URLComponents()
    components.queryItems = [
      URLQueryItem(name: "grant_type", value: "authorization_code"),
      URLQueryItem(name: "code", value: code),
      URLQueryItem(name: "redirect_uri", value: AuthViewController.Const.redirect_uri),
    // For PCKE extension
      
//      URLQueryItem(name: "client_id", value: AuthViewController.Const.clientID),
//      URLQueryItem(name: "code_verifier", value: code)
    ]
    
    request.httpBody = components.query?.data(using: .utf8)
    
    return URLSession.shared.dataTaskPublisher(for: request)
      .map({$0.data})
      .decode(type: TokenResponse.self, decoder: JSONDecoder())
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
  
  public func getRecommendedGenres() -> Set<String> {
    guard let request = createRequestWithToken(url: URL(string: Const.baseAPIURL + "/recommendations/available-genre-seeds"), method: "GET")
    else { return [] }
    
    var genres = Set<String>()
    
    let publisher = URLSession.shared.dataTaskPublisher(for: request)
      .map { $0.data }
      .decode(type: RecommendedGenresResponse.self,
              decoder: JSONDecoder())
//      .mapError(ApiError.responseError)
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()

    subscriber = publisher.sink { completion in
      switch completion {
      case .finished:
        break
      case .failure(let error):
        print(error)
      }
    } receiveValue: { achievedGenres in
      _ = achievedGenres.genres.reduce(0) { res, el in
        if res < 5 { genres.insert(el)}
        return res + 1
    }
      print(genres)
  }
    return genres
}
  
  public func getRecommendationsTracks() -> [AudioTrack] {
    let seeds = getRecommendedGenres().joined(separator: ",")
    print(seeds)
    
    guard let request = createRequestWithToken(url: URL(string: Const.baseAPIURL + "/recommendations?seed_genres=\(seeds)&seed_artists=&seed_tracks=&limit=40"), method: "GET") else { return [] }

    let audioTracks = [AudioTrack]()
    
    let publisher = URLSession.shared.dataTaskPublisher(for: request)
      .map { $0.data }
      .decode(type: RecommendationResponse.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()

    return audioTracks
  }
  
  // MARK: - Private
  
  private func createRequestWithToken(url: URL?, method: String) -> URLRequest? {
    guard let apiURL = url else { return nil}
    guard let token = StorageManager.shared.keychain.get(StorageManager.Const.token) else { return nil }
    var request = URLRequest(url: apiURL)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.httpMethod = method
    request.timeoutInterval = 30
    return request
  }
}
