//
//  TabBarController.swift
//  Rick and Morty
//
//  Created by Vitaliy Iakushev on 31.12.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let episodesScreen = EpisodesViewController()
        let favouritesScreen = FavouritesViewController()
        
        let episodesNavController = UINavigationController(rootViewController: episodesScreen)
        let favouritesNavController = UINavigationController(rootViewController: favouritesScreen)
        
        episodesNavController.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "house.fill"), tag: 0)
        favouritesNavController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), tag: 1)
        
        
        self.viewControllers = [episodesNavController, favouritesNavController]
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.5)
        topBorder.backgroundColor = UIColor.lightGray.cgColor
        topBorder.shadowColor = UIColor.gray.cgColor
        topBorder.shadowOpacity = 1.5
        topBorder.shadowOffset = CGSize(width: 0, height: 2)
        topBorder.shadowRadius = 4
        tabBar.layer.addSublayer(topBorder)
    }
    
}

