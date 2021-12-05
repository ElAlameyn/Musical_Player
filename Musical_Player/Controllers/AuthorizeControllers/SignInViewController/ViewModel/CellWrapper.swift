import UIKit

struct CellWrapper {
  let cell: (UITableView, IndexPath, SignInViewController.ViewModel.Info) -> UITableViewCell
  
  static func inputCell(
    cellInfo: InputCell.CellInfo,
    output: @escaping (_ text: String, _ key: String) -> Void
  ) -> CellWrapper {
    CellWrapper { tableView, indexPath, info in
      let cell: InputCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
      cell.fill(info: cellInfo, value: cellInfo.key)
      cell.textChanged = { text in
        output(text, cellInfo.key)
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
