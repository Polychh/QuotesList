//
//  File.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import UIKit
protocol RouterProtocolMain{
    var navigationController: UINavigationController { get }
    var builder: BuilderVC { get }
}

protocol RouterQuotesListProtocol: RouterProtocolMain{
    func categoryViewController()
    func detailViewController(categoty: String)
}

final class RouterQuotesList: RouterQuotesListProtocol{
    
    var navigationController: UINavigationController
    
    var builder: BuilderVC
    init(navigationController: UINavigationController, builder: BuilderVC) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func categoryViewController() {
        let mainVC = builder.buildQuatesListVC(router: self)
        navigationController.viewControllers = [mainVC]
    }
    
    func detailViewController(categoty: String) {
        let detailVC = builder.buildDetailQuoteVC(category: categoty)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
 
}
