//
//  TabBarViewController.swift
//  TrendyolUIKit
//
//  Created by Mehmet Ateş on 6.05.2022.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.tintColor = .orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: Home
        let home = HomeViewController()
        let homeIcon = createTabButton(title: "AnaSayfa", image: "house")
        home.tabBarItem = homeIcon
        
        // MARK: Go
        let go = GoViewController()
        let goIcon = createTabButton(title: "Go", image: "speedometer")
        go.tabBarItem = goIcon
        
        // MARK: Favorite
        let favorite = FavoriteViewController()
        let favoriteIcon = createTabButton(title: "Favorilerim", image: "heart")
        favorite.tabBarItem = favoriteIcon
        
        // MARK: Basket
        let basket = BasketViewController()
        let basketIcon = createTabButton(title: "Sepetim", image: "bag")
        basket.tabBarItem = basketIcon
        
        // MARK: Profile
        let profile = ProfileViewController()
        let profileIcon = createTabButton(title: "Hesabım", image: "person")
        profile.tabBarItem = profileIcon
        
        let controllers = [home, go, favorite, basket, profile]
        self.viewControllers = controllers
        
    }

    private func createTabButton(title: String, image: String) -> UITabBarItem{
        return UITabBarItem(title: title, image: UIImage(systemName: image), selectedImage: nil)
    }
}
