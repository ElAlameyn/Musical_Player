
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.navigationItem.setHidesBackButton(true, animated: true)
      self.title = "Featured tracks"

      setViewControllers([addBaseVC(), addCollectionVC()], animated: true)
    }
  
  private func addBaseVC() -> UIViewController {
    let baseVC = BaseViewController()
    baseVC.tabBarItem.title = Localizable.tabBarHomeTitle
    baseVC.tabBarItem.image = UIImage(systemName: Constants.tabBarHomeImageName)
    return baseVC
  }
  
  private func addCollectionVC() -> UIViewController {
    let collectionVC = LibraryController()
    collectionVC.tabBarItem.title = Localizable.tabBarHomeTitle
    collectionVC.tabBarItem.image = UIImage(systemName: Constants.tabBarHomeImageName)
    return collectionVC
  }
  
}
