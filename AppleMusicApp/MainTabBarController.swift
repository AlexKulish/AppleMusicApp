//
//  MainTabBarController.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 31.08.2022.
//

import UIKit
import SwiftUI

protocol MainTabBarControllerDelegate: AnyObject {
    func minimizeTrackDetailsView()
    func maximizeTrackDetailsView(viewModel: SearchViewModel.Cell?)
}

class MainTabBarController: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    let trackDetailsView: TrackDetailsView = TrackDetailsView.loadFromNib()
    
    private var minimizedTopAnchorConstraint: NSLayoutConstraint!
    private var maximizedTopAnchorConstraint: NSLayoutConstraint!
    private var bottomAnchorConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTrackDetailsView()
        searchVC.tabBarDelegate = self
        trackDetailsView.tabBarDelegate = self
        trackDetailsView.delegate = searchVC
    }
    
    private func setupTabBar() {
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.2823529412, blue: 0.4078431373, alpha: 1)
        
        let library = Library()
        let hostVC = UIHostingController(rootView: library)
        
        viewControllers = [
            generateViewController(rootViewController: searchVC, image: UIImage(named: "Search"), title: "Search"),
            generateViewController(rootViewController: hostVC, image: UIImage(named: "Library"), title: "Library")
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
        
        view.insertSubview(trackDetailsView, belowSubview: tabBar)
        trackDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        minimizedTopAnchorConstraint = trackDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        maximizedTopAnchorConstraint = trackDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        
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
    
    func maximizeTrackDetailsView(viewModel: SearchViewModel.Cell?) {
        
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 0
            self.trackDetailsView.maximizedStackView.alpha = 1
            self.trackDetailsView.miniTrackDetailsView.alpha = 0
        }, completion: nil)
        
        guard let viewModel = viewModel else { return }
        trackDetailsView.configure(viewModel: viewModel)
    }
    
    func minimizeTrackDetailsView() {
        
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 1
            self.trackDetailsView.maximizedStackView.alpha = 0
            self.trackDetailsView.miniTrackDetailsView.alpha = 1
        }, completion: nil)
    }
    
}
