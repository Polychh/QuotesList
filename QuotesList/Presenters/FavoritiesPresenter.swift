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
    
    func getSaveQuotes(){
        saveQuotes = StoreManager.shared.fetchQuotes()
        view?.reloadTableView()
    }
    
    func deleteAllFavs() {
        StoreManager.shared.deleteAllQuotes()
        saveQuotes = StoreManager.shared.fetchQuotes()
        view?.reloadTableView()
    }
    
    func deleteOneItem(textQuote: String){
        StoreManager.shared.deleteOneQuotes(with: textQuote)
        saveQuotes = StoreManager.shared.fetchQuotes()
        view?.reloadTableView()
    }
}
