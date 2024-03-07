//
//  JokePresenter.swift
//  QuotesList
//
//  Created by Polina on 07.03.2024.
//

import Foundation
protocol JokePresenterVCProtocol: AnyObject{
    func activityIndicStop()
    func activityIndicStart()
    func reloadTableview()
}

protocol JokePresenterProtocol{
    var jokeArray: Jokes { get }
    func starActivityIndicator()
    func getData()
}

final class JokePresenter: JokePresenterProtocol {
    var jokeArray: Jokes = .init()
    
    private var isLoaded: Bool = false
        
    weak var view: JokePresenterVCProtocol?
    
    private let network: NetworkServiceProtocol
    
    init(network: NetworkServiceProtocol) {
        self.network = network
    }
    
    func starActivityIndicator() {
        if !isLoaded{
            view?.activityIndicStart()
        }
    }
    
    func getData() {
        if jokeArray.isEmpty{
            getDataForJokes()
        } else {
            isLoaded = true
        }
    }
    
    private func getDataForJokes(){
        isLoaded = false
        let request = JokeRequest()
        network.request(request) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let result):
                jokeArray = result
                print("Done joke \(result)")
                view?.activityIndicStop()
                view?.reloadTableview()
                isLoaded = true
            case .failure(let error):
                print("Network Error \(error.rawValue)")
            }
        }
    }
}
