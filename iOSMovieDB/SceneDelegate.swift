//
//  SceneDelegate.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 02/12/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let rootController = MovieListModule().build()
        window.rootViewController = rootController
        self.window = window
        window.makeKeyAndVisible()
    }
}

