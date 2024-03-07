//
//  QuateListBuilder.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import UIKit
protocol BuilderMainVCFlowProtocol{
    func buildQuatesListVC(router: RouterQuotesListProtocol) -> UIViewController
    func buildDetailQuoteVC(category: String) -> UIViewController
}

final class BuilderMainVCFlow: BuilderMainVCFlowProtocol{
    func buildQuatesListVC(router: RouterQuotesListProtocol) -> UIViewController {
        let vc = QuotesListViewController()
        vc.title = "Quotes Categories"
        let presenter = QuotesListPresenter(roter: router)
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
    
    func buildDetailQuoteVC(category: String) -> UIViewController {
        let vc = QuoteDetailViewController()
        vc.title = "Quote By Category \(category)"
        let networkSetvice = NetworkService()
        let presenter = QuoteDetailPresenter(category: category, network: networkSetvice)
        presenter.view = vc
        vc.presenter = presenter
        return vc
    }
}
