//
//  AppDelegate.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 02/12/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootController = MovieListModule().build()

        window = UIWindow()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
            
        return true
    }
}

