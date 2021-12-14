import UIKit
import WebKit
import Combine

class AuthViewController: UIViewController, WKNavigationDelegate {
  private let webView = WKWebView()
  
  var subscriber: AnyCancellable?
  
  enum Const {
    static let baseURL = "https://accounts.spotify.com/authorize?"
    static let clientID = "52bef5d50508454eb7d3b4e89270c940"
    static let clientServer = "47d3ecf318a24a6fabd75c811fc87cd9"
    static let redirect_uri = "https://developer.spotify.com"
    static let tokenAPIURl =  "https://accounts.spotify.com/api/token"
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      webView.navigationDelegate = self
      
      view.addSubview(webView)
      webView.addEdgeConstraints(offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
      
      guard let url = URL(
        string:
          Const.baseURL
        + "client_id=\(Const.clientID)"
        + "&response_type=code"
        + "&redirect_uri=\(Const.redirect_uri)"
        + "&show_dialog=true"
      )
      
      else { return }
      
#warning("add 2 more parameters to implement PCKE extension")
      
      webView.load(URLRequest(url: url))
    }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    guard let url = webView.url else { return }
    let components = URLComponents(string: url.absoluteString)
    
    guard
      let code = components?.queryItems?.first(where: {$0.name == "code"}),
      let tokenURL = URL(string: Const.tokenAPIURl)
    else { return }

    subscriber = SpotifyAPI.shared.getToken(with: code.value ?? "", url: tokenURL)
      .sink(receiveCompletion: {_ in}, receiveValue: { [weak self] tokenResponse in
        StorageManager.shared.saveToken(token: tokenResponse.access_token)
        print("Token: \(tokenResponse.access_token)")
        self?.dismiss(animated: true, completion: nil)
    })
  }
}

