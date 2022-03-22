//
//  SceneDelegate.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MoviesTabBarController()
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = UserDefaults.standard.theme.getUserInterfaceStyle()
    }
}

