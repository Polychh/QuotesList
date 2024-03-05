//
//  QuoteDetailPresenter.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import Foundation

protocol QuoteDetailVCProtocol: AnyObject{
    func activityIndicStop()
    func activityIndicStart()
    func addTextToLabel()
}

protocol QuoteDetailPresenterProtocol{
    var textArray: QuoteByCaregory { get }
    func starActivityIndicator()
}

final class QuoteDetailPresenter: QuoteDetailPresenterProtocol{
    var textArray: QuoteByCaregory = .init()
    
    weak var view: QuoteDetailVCProtocol?
    private let category: String
    private let networkService: NetworkServiceProtocol
    
    init(category: String, network: NetworkServiceProtocol) {
        self.category = category
        self.networkService = network
        getDataForCategory(category: category)
    }
    
    func starActivityIndicator() {
        view?.activityIndicStart()
    }
    
    private func getDataForCategory(category: String){
        networkService.getQuoteByCatery(for: category) {  [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let result):
                textArray = result
                print("Done \(result)")
                view?.activityIndicStop()
                view?.addTextToLabel()
            case .failure(let error):
                print("Network Error \(error.rawValue)")
            }
        }
    }
}
