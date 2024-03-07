//
//  QuoteTabBarController.swift
//  QuotesList
//
//  Created by Polina on 05.03.2024.
//

import UIKit

final class QuoteTabBarController: UITabBarController {
    
    let builderTabFlow: BulderTabBarProtocol
    
    init(builderTabFlow: BulderTabBarProtocol) {
        self.builderTabFlow = builderTabFlow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearence()
        generateTabBar(builderTabBarFlow: builderTabFlow)
    }
    
    private func generateTabBar(builderTabBarFlow: BulderTabBarProtocol){
        let mainTab = builderTabBarFlow.buildMainVCFlow(nav: generateVC(title: "Main", image: UIImage(systemName: "house")))
        let favorTab = builderTabBarFlow.buildFavoriteVCFlow(nav: generateVC(title: "Favories", image: UIImage(systemName: "star.fill")))
        let jokeTab = builderTabBarFlow.buildJokeVCFlow(nav: generateVC(title: "Joke", image: UIImage(systemName: "lightbulb.fill")))
        self.setViewControllers([mainTab, favorTab, jokeTab], animated: true)
    }
    
    private func generateVC( title: String, image: UIImage?) -> UINavigationController{
        let nav = UINavigationController()
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.navigationBar.titleTextAttributes =  [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        ]
        return nav
    }
    
    private func setTabBarAppearence(){
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
}
