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

  public func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse, Error>) -> Void)) {
    
    guard let request = createRequestWithToken(url: URL(string: Const.baseAPIURL + Const.recommendedGenres), method: "GET") else {
      completion(.failure(ApiError.urlError))
      return
    }
    
      URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(ApiError.responseError))
          return
        }
        
        do {
          let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
          completion(.success(result))
        } catch {
          completion(.failure(error))
        }
      }.resume()
      
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
