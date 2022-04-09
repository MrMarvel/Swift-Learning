//
//  TabBarController.swift
//  SergeySenlaApp
//
//  Created by Сергей Куликов on 08.04.2022.
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
        tabBar.isOpaque = false
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .black
        tabBar.backgroundColor = .systemBlue
        setupTabBar()
    }
}

private extension TabBarController {
    
    func setupTabBar() {
        //
        let mainVC = RockPaperScissorsController()
        let SecondVC = CubeGameController()
        
        let navMain = NavigationController(
            rootViewController: mainVC
        )
        
        navMain.navigationBar.tintColor = .black
        
        navMain.tabBarItem = UITabBarItem(
            title: "RSP",
            image: UIImage(systemName: "scissors"),
            tag: 1
        )
        
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 19, weight: .bold
        )
        navMain.tabBarItem.selectedImage = UIImage(systemName: "scissors", withConfiguration: configuration)
        
        let navSecond = NavigationController(
            rootViewController: SecondVC
        )
        navSecond.tabBarItem = UITabBarItem(
            title: "DICE",
            image: UIImage(systemName: "cube"),
            tag: 1)
        navSecond.tabBarItem.selectedImage = UIImage(systemName: "cube.fill", withConfiguration: configuration)
        
//        tabBar.viewControllers = [navMain, navSecond]
        //
        
        setViewControllers([
            navMain, navSecond
        ], animated: false)
    }
}
