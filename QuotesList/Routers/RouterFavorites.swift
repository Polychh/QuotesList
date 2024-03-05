//
//  RouterFavoriteVC.swift
//  QuotesList
//
//  Created by Polina on 05.03.2024.
//

import UIKit
protocol RouterFavoritesProtocol: RouterProtocolMain{
   func createFavoriteVC()
}

final class RouterFavorites: RouterFavoritesProtocol{
    var navigationController: UINavigationController
    
    var builder: BuilderVC
    
    init(navigationController: UINavigationController, builder: BuilderVC) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func createFavoriteVC() {
        let favoriteVC = builder.buildFavotitiesVC()
        navigationController.viewControllers = [favoriteVC]
    }
}
