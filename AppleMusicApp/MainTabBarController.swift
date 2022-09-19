//
//  MainTabBarController.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 31.08.2022.
//

import UIKit

protocol MainTabBarControllerDelegate: AnyObject {
    func minimizeTrackDetailsView()
}

class MainTabBarController: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    
    private var minimizedTopAnchorConstraint: NSLayoutConstraint!
    private var maximizedTopAnchorConstraint: NSLayoutConstraint!
    private var bottomAnchorConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTrackDetailsView()
    }
    
    private func setupTabBar() {
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.2836539447, blue: 0.4059218168, alpha: 1)
        
        viewControllers = [
            generateViewController(rootViewController: searchVC, image: UIImage(named: "Search"), title: "Search"),
            generateViewController(rootViewController: ViewController(), image: UIImage(named: "Library"), title: "Library")
        ]
        
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage?, title: String) -> UIViewController {
        
        rootViewController.title = title
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
    
    private func setupTrackDetailsView() {
        
        let trackDetailsView: TrackDetailsView = TrackDetailsView.loadFromNib()
        trackDetailsView.backgroundColor = .blue
        trackDetailsView.tabBarDelegate = self
        trackDetailsView.delegate = searchVC
        view.insertSubview(trackDetailsView, belowSubview: tabBar)
        trackDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        minimizedTopAnchorConstraint = trackDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        maximizedTopAnchorConstraint = trackDetailsView.topAnchor.constraint(equalTo: view.topAnchor)
        
        bottomAnchorConstraint = trackDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        maximizedTopAnchorConstraint.isActive = true
        bottomAnchorConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            trackDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trackDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
}

extension MainTabBarController: MainTabBarControllerDelegate {
    
    func minimizeTrackDetailsView() {
        
        maximizedTopAnchorConstraint.isActive = false
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
}
