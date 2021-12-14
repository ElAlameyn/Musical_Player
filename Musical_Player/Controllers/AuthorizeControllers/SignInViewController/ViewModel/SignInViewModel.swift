
import UIKit

extension SignInViewController {
  
  class ViewModel {
    
    var continueButtonTapped: ((Info) -> Void)?
    
    class Info: NSObject {
      @objc var email: String
      @objc var password: String
      
      init(email: String, password: String) {
        self.email = email
        self.password = password
      }
    }
    
    private(set) var info = Info(email: "", password: "")

    private var cellWrappers: [CellWrapper] = []
    
    init() {
      cellWrappers = [
        .inputCell(cellInfo: .email, output: { [weak self] text, key in
          self?.info.setValue(text, forKey: key)
        }),
        .inputCell(cellInfo: .password, output: { [weak self] text, key in
          self?.info.setValue(text, forKey: key)
        }),
        .logInButton(output: { [unowned self] in
          self.continueButtonTapped?(self.info)
        })
      ]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
      cellWrappers.count
    }
    
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
      let cell = cellWrappers[indexPath.row].cell(tableView, indexPath, info)
      return cell
    }
  }
}

