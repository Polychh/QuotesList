//
//  JokeRouter.swift
//  QuotesList
//
//  Created by Polina on 07.03.2024.
//

import UIKit
protocol JokeRouterProtocol: RouterProtocolMain{
   var builder: BuilderJokeVCFlowProtocol { get }
   func createJokeVC()
}

final class RouterJoke: JokeRouterProtocol{
    var navigationController: UINavigationController
    
    var builder: BuilderJokeVCFlowProtocol
    
    init(navigationController: UINavigationController, builder: BuilderJokeVCFlowProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func createJokeVC() {
        let jokeVC = builder.buildJokeVC()
        navigationController.viewControllers = [jokeVC]
    }
}
