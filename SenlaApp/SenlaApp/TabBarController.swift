//
//  TabBarController.swift
//  SenlaApp
//
//  Created by Student on 26.03.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isOpaque = true
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .white
        tabBar.backgroundColor = .yellow
        setupTabBar()
        // Do any additional setup after loading the view.
    }

}

private extension TabBarController {
    func setupTabBar() {
        let navVCContent = NavigationController(rootViewController: ContentViewController())
        let navCInfo = NavigationController(rootViewController: InfoViewController())
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 23, weight: .semibold)
        
        navVCContent.tabBarItem = UITabBarItem(
            title: "Content",
            image: UIImage(systemName: "folder"),
            selectedImage: UIImage(systemName: "folder.fill",
                                   withConfiguration: configuration)
        )
        navCInfo.tabBarItem = UITabBarItem(
            title: "Info",
            image: UIImage(systemName: "pencil.circle"),
            selectedImage: UIImage(systemName: "pencil.circle.fill",
                                   withConfiguration: configuration)
        )
        setViewControllers(
            [navCInfo, navVCContent], animated: false)
    }
}
