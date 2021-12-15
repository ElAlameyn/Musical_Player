
import UIKit
import Combine

class SearchMusicController: UIViewController, UISearchResultsUpdating {

  let searchController = UISearchController()
  let tracks = [AudioTrack]()
  var currentPage = 1
  var isLoading = false
  var subscriber: AnyCancellable?
  var tableView = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search some awesome tracks"
      view.backgroundColor = .systemBackground
      
      navigationItem.searchController = searchController
      searchController.searchResultsUpdater = self
      
      configTableView()
    }
  
  private func configTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(TrackViewCell.self)
    
    view.addSubview(tableView)
    
    tableView.addEdgeConstraints(offset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
}

extension SearchMusicController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tracks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: TrackViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
    return cell
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    subscriber = NotificationCenter.default
      .publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
      .map({($0.object as? UISearchTextField)?.text})
      .receive(on: RunLoop.main)
      .sink(receiveValue: {[weak self] text in
        if let text = text {
          self?.currentPage = 1
          guard let isLoading = self?.isLoading, !isLoading  else { return }
          self?.isLoading = true
          
        #warning("ADD REQUEST")
          
          DispatchQueue.main.async {
            self?.tableView.reloadData()
          }
          self?.isLoading = false
        }
      })
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let lastElement = tracks.count - 1
    if indexPath.row == lastElement && !isLoading {
      if let text = searchController.searchBar.text {
        currentPage += 1
        isLoading = true
        
        let oldCount = self.tracks.count
        
        #warning("ADD REQUEST")
        
        self.isLoading = false
        
//        DispatchQueue.main.async {
//          let indexPaths = (oldCount ..< (oldCount + )).map { index in
//              IndexPath(row: index, section: 0)
//         }
//        }
//        self.tableView.insertRows(at: indexPaths, with: .automatic)
      }
    }
  }
  

}
