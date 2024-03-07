//
//  BuilderTabBarQuote.swift
//  QuotesList
//
//  Created by Polina on 07.03.2024.
//

import UIKit

protocol BulderTabBarProtocol{
    func buildMainVCFlow(nav: UINavigationController) -> UINavigationController
    func buildFavoriteVCFlow(nav: UINavigationController) -> UINavigationController
}

final class BuilderTabBarQuote: BulderTabBarProtocol{
    func buildMainVCFlow(nav: UINavigationController) -> UINavigationController   {
        let builder = BuilderMainVCFlow()
        let mainRouter = RouterQuotesList(navigationController: nav, builder: builder)
        mainRouter.categoryViewController()
        return mainRouter.navigationController
    }
    
    func buildFavoriteVCFlow(nav: UINavigationController) -> UINavigationController {
        let builder = BuilderFavVCFlow()
        let favoritesRouter = RouterFavorites(navigationController: nav, builder: builder)
        favoritesRouter.createFavoriteVC()
        return favoritesRouter.navigationController
    }
}
