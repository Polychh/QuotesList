//
//  QuoteDetailPresenter.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import Foundation
import CoreData

protocol QuoteDetailVCProtocol: AnyObject{
    func activityIndicStop()
    func activityIndicStart()
    func addTextToLabel()
    func hideBackView()
}

protocol QuoteDetailPresenterProtocol{
    var textArray: QuoteByCaregory { get }
    func starActivityIndicator()
    func saveFavorities()
    func getData()
   
}

final class QuoteDetailPresenter: QuoteDetailPresenterProtocol{
    var textArray: QuoteByCaregory = .init()
    private var isLoaded: Bool = false
    
    weak var view: QuoteDetailVCProtocol?
    private let category: String
    private let networkService: NetworkServiceProtocol
    private let storeManager: StoreManagerProtocol
    
    init(category: String, network: NetworkServiceProtocol, storeManager: StoreManagerProtocol) {
        self.category = category
        self.networkService = network
        self.storeManager = storeManager
    }
    
    func starActivityIndicator() {
        if !isLoaded{
            view?.activityIndicStart()
        }
    }
    
    func saveFavorities(){
        let data = textArray[0]
        storeManager.createFavoriteQuote(category: data.category, author: data.author, quoteText: data.quote)
    }
    
    func getData(){
        if textArray.isEmpty{
            getDataForCategory(category: category)
        } else {
            view?.hideBackView()
            isLoaded = true
        }
    }
    
    private func getDataForCategory(category: String){
        isLoaded = false
        let request = CategoryQuoteRequest(category: category)
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let result):
                textArray = result
                print("Done \(result)")
                view?.activityIndicStop()
                view?.hideBackView()
                view?.addTextToLabel()
                isLoaded = true
            case .failure(let error):
                print("Network Error \(error.rawValue)")
            }
        }
    }
}
