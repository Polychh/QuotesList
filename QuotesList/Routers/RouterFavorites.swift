//
//  RouterFavoriteVC.swift
//  QuotesList
//
//  Created by Polina on 05.03.2024.
//

import UIKit
protocol RouterFavoritesProtocol: RouterProtocolMain{
   var builder: BuilderFavVCFlowProtocol { get }
   func createFavoriteVC()
}

final class RouterFavorites: RouterFavoritesProtocol{
    var navigationController: UINavigationController
    
    var builder: BuilderFavVCFlowProtocol
    
    init(navigationController: UINavigationController, builder: BuilderFavVCFlowProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func createFavoriteVC() {
        let favoriteVC = builder.buildFavotitiesVC()
        navigationController.viewControllers = [favoriteVC]
    }
}
