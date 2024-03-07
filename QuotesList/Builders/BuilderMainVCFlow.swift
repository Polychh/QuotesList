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
        let presenter = QuotesListPresenter(roter: router)
        let vc = QuotesListViewController(presenter: presenter)
        vc.title = "Quotes Categories"
        presenter.view = vc
        return vc
    }
    
    func buildDetailQuoteVC(category: String) -> UIViewController {
        let storeManager = StoreManager()
        let networkSetvice = NetworkService()
        let presenter = QuoteDetailPresenter(category: category, network: networkSetvice, storeManager: storeManager)
        let vc = QuoteDetailViewController(presenter: presenter)
        vc.title = "Quote By Category \(category)"
        presenter.view = vc
        return vc
    }
}
