//
//  MainTabBarController.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 31.08.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.2836539447, blue: 0.4059218168, alpha: 1)
        
        let searchVC = addViewController(rootViewController: SearchTableViewController(), image: UIImage(named: "Search"), title: "Search")
        let libraryVC = addViewController(rootViewController: ViewController(), image: UIImage(named: "Library"), title: "Library")
        
        viewControllers = [searchVC, libraryVC]
        
    }
    
    private func addViewController(rootViewController: UIViewController, image: UIImage?, title: String) -> UIViewController {
        
        rootViewController.title = title
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
    
    
}
