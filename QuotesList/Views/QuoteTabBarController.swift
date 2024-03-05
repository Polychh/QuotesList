//
//  QuoteTabBarController.swift
//  QuotesList
//
//  Created by Polina on 05.03.2024.
//

import UIKit

final class QuoteTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearence()
        generateTabBar()
    }
    
    private func generateTabBar(){
        let builder = BuilderQuateList()
        let mainRouter = RouterQuotesList(navigationController: generateVC(title: "Main", vcTitle: "Quotes Categories", image: UIImage(systemName: "house")), builder: builder)
        mainRouter.categoryViewController()
        let favoritesRouter = RouterFavorites(navigationController: generateVC(title: "Favories", vcTitle: "Quote", image: UIImage(systemName: "star.fill")), builder: builder)
        favoritesRouter.createFavoriteVC()
        self.setViewControllers([mainRouter.navigationController, favoritesRouter.navigationController], animated: true)
    }
    
    private func generateVC( title: String, vcTitle: String, image: UIImage?) -> UINavigationController{
        let nav = UINavigationController()
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = vcTitle
        nav.navigationBar.titleTextAttributes =  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
        return nav
    }
    
    private func setTabBarAppearence(){
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor.blue.cgColor
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
}
