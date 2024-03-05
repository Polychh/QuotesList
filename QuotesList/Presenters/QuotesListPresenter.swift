//
//  QuatesListPresenter.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import Foundation

protocol QuotesListVCProtocol: AnyObject{
    func reload()
}

protocol QuotesListPresenterProtocol{
    var isFilter: Bool { get }
    var quatesListArray: [Quote] { get }
    var quatesListArrayFilter: [Quote] { get }
    func filterCategories(text: String)
    func routeToDetail(category: String)
}


final class QuotesListPresenter: QuotesListPresenterProtocol{
    weak var view: QuotesListVCProtocol?
    
    private let router: RouterQuotesListProtocol
    
    var quatesListArray: [Quote] = .init()
    var quatesListArrayFilter: [Quote] = .init()
    var isFilter: Bool = false
    private let model = QuotesListModel.getQuotesList()
    
    init(roter: RouterQuotesListProtocol) {
        self.router = roter
        getData()
    }
    
    func filterCategories(text: String){
        isFilter = text.isEmpty ? false : true
        quatesListArrayFilter = isFilter ? quatesListArray.filter { $0.category.contains(text)} : []
        view?.reload()
    }
    
    func getData() {
        quatesListArray = model.quote.shuffled()
        print("getData \(quatesListArray.count)")
        view?.reload()
    }
    
    func routeToDetail(category: String) {
        router.detailViewController(categoty: category)
    }
    
 
}
