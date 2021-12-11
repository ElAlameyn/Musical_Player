
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let nav1 = createNavController(for: BaseViewController(), title: Localizable.tabBarHomeTitle, image: UIImage(systemName: Localizable.tabBarHomeImageName) ?? nil)
      let nav2 = createNavController(for: LibraryController(), title: Localizable.tabBarCollectionTitle, image: UIImage(systemName: Localizable.tabBarCollectionImageName))
      
      tabBar.backgroundColor = .systemBackground
      
      setViewControllers([nav1, nav2], animated: true)
    }
  
  fileprivate func createNavController(for rootViewController: UIViewController,
                                                  title: String,
                                                  image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
}
