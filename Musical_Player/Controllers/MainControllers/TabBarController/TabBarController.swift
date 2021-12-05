//
//  TabBarController.swift
//  Musical_Player
//
//  Created by Артем Калинкин on 04.12.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let baseViewController = BaseViewController()
      let userInfoController = LibraryController()
      
      baseViewController.title = "Music"
      userInfoController.title = "User"

      let nav1 = UINavigationController(rootViewController: baseViewController)
      let nav2 = UINavigationController(rootViewController: userInfoController)
      
      nav1.tabBarItem = UITabBarItem(title: Localizable.tabBarHomeTitle, image: UIImage(systemName: Localizable.tabBarHomeImageName), tag: 1)
      
      nav2.tabBarItem = UITabBarItem(title: Localizable.tabBarCollectionTitle, image: UIImage(systemName: Localizable.tabBarCollectionImageName), tag: 1)
      
      nav1.navigationBar.tintColor = .label
      nav2.navigationBar.tintColor = .label
      
      tabBar.backgroundColor = .systemBackground
      
      setViewControllers([nav1, nav2], animated: true)
    }
    
}
