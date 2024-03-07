//
//  FavoritiesPresenter.swift
//  QuotesList
//
//  Created by Polina on 06.03.2024.
//

import Foundation

protocol FavoritiesVCProtocol: AnyObject{
    func reloadTableView()
}

protocol FavoritiesPresenterProtocol{
    var saveQuotes: [SavesQuote] { get }
    func getSaveQuotes()
    func deleteAllFavs()
    func deleteOneItem(textQuote: String)

}

final class FavoritiesPresenter: FavoritiesPresenterProtocol{
    var saveQuotes: [SavesQuote] = .init()
    weak var view: FavoritiesVCProtocol?
    private let storeManager: StoreManagerProtocol
    
    init(storeManager: StoreManagerProtocol) {
        self.storeManager = storeManager
    }
    
    func getSaveQuotes(){
        saveQuotes = storeManager.fetchQuotes()
        view?.reloadTableView()
    }
    
    func deleteAllFavs() {
        storeManager.deleteAllQuotes()
        saveQuotes = storeManager.fetchQuotes()
        view?.reloadTableView()
    }
    
    func deleteOneItem(textQuote: String){
        storeManager.deleteOneQuotes(with: textQuote)
        saveQuotes = storeManager.fetchQuotes()
        view?.reloadTableView()
    }
}
