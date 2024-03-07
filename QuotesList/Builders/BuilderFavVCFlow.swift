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
        let vc = FavoritiesViewController()
        vc.title = "Favorite Quotes"
        let presenter = FavoritiesPresenter()
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
}
