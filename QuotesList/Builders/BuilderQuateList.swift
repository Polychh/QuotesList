//
//  QuateListBuilder.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import UIKit
protocol BuilderVC{
    func buildQuatesListVC(router: RouterQuotesListProtocol) -> UIViewController
    func buildDetailQuoteVC(category: String) -> UIViewController
}

final class BuilderQuateList: BuilderVC{
    func buildQuatesListVC(router: RouterQuotesListProtocol) -> UIViewController {
        let vc = QuotesListViewController()
        let presenter = QuotesListPresenter(roter: router)
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    func buildDetailQuoteVC(category: String) -> UIViewController {
        let vc = QuoteDetailViewController()
        let networkSetvice = NetworkService()
        let presenter = QuoteDetailPresenter(category: category, network: networkSetvice)
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
}
