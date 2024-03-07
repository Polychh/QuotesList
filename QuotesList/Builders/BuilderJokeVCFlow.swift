//
//  BuilderJokeVCFlow.swift
//  QuotesList
//
//  Created by Polina on 07.03.2024.
//

import UIKit
protocol BuilderJokeVCFlowProtocol{
    func buildJokeVC() -> UIViewController
}

final class BuilderJokeVCFlow: BuilderJokeVCFlowProtocol{
    func buildJokeVC() -> UIViewController{
        let network = NetworkService()
        let presenter = JokePresenter(network: network)
        let vc = JokeViewController(presenter: presenter)
        vc.title = "Jokes"
        presenter.view = vc
        return vc
    }
}
