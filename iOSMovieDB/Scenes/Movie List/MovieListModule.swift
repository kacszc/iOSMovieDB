//
//  MovieListModule.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import UIKit

class MovieListModule {
    func build() -> UIViewController {
        let viewModel = MovieListViewModel(
            cacheService: FavouriteCacheService()
        )

        let controller = MovieListViewController(
            viewModel: viewModel
        )
        let navController = UINavigationController(rootViewController: controller)

        viewModel.presenter = controller
        controller.title = "Movie list"

        return navController
    }
}
