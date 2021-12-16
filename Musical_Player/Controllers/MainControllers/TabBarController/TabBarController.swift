
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

      self.navigationItem.setHidesBackButton(true, animated: true)
      setViewControllers([addBaseVC(), addCollectionVC()], animated: true)
    }
  
  private func addBaseVC() -> UIViewController {
    let baseVC = BaseViewController()
    baseVC.tabBarItem.title = Localizable.tabBarHomeTitle
    baseVC.tabBarItem.image = UIImage(systemName: Constants.tabBarHomeImageName)
    return baseVC
  }
  
  private func addCollectionVC() -> UIViewController {
    let collectionVC = SearchMusicController()
    collectionVC.tabBarItem.title = Localizable.tabBarCollectionTitle
    collectionVC.tabBarItem.image = UIImage(systemName: Constants.tabBarCollectionImageName)
    let nav = UINavigationController(rootViewController: collectionVC)
    return nav
  }
  
}
