import UIKit

struct CellWrapper {
  let cell: (UITableView, IndexPath, SignInViewController.ViewModel.Info) -> UITableViewCell
  
  static func inputCell(
    cellInfo: InputCell.CellInfo,
    output: @escaping (_ text: String, _ key: String) -> Void
  ) -> CellWrapper {
    CellWrapper { tableView, indexPath, info in
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
      cell.fill(info: cellInfo)
      
      cell.textChanged = { text in
        let result = cellInfo.validator.run(text)
        switch result {
        case .validated(let string):
          output(string, cellInfo.key)
          cell.backgroundColor = .green
        case .error(_):
          cell.backgroundColor = .red
        }
      }
      return cell
    }
  }
  
  static func logInButton(output: @escaping () -> Void) -> CellWrapper {
    CellWrapper { tableView, indexPath, _ in
      let cell: ButtonTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      
      cell.buttonTapped = {
        output()
      }
      return cell
    }
  }
}
