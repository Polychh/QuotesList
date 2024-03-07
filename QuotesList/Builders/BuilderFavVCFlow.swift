//
//  BuilderFavVCFlow.swift
//  QuotesList
//
//  Created by Polina on 07.03.2024.
//

import UIKit
protocol BuilderFavVCFlowProtocol{
    func buildFavotitiesVC() -> UIViewController
}

final class BuilderFavVCFlow: BuilderFavVCFlowProtocol{
    func buildFavotitiesVC() -> UIViewController{
        let storeManager = StoreManager()
        let presenter = FavoritiesPresenter(storeManager: storeManager)
        let vc = FavoritiesViewController(presenter: presenter)
        vc.title = "Favorite Quotes"
        presenter.view = vc
        return vc
    }
}
