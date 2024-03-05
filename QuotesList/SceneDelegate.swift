//
//  SceneDelegate.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController()
        let builder = BuilderQuateList()
        let router = RouterQuotesList(navigationController: navController, builder: builder)
        router.categoryViewController()
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}

