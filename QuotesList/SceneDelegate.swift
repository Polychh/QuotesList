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
        let builderTabBarFlow = BuilderTabBarQuote()
        let tabBarController = QuoteTabBarController(builderTabFlow: builderTabBarFlow)
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}

