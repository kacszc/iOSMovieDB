//
//  MovieDetailsModule.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import UIKit

class MovieDetailsModule {
    func build(for movie: Movie) -> UIViewController {
        let viewModel = MovieDetailsViewModel(
            cacheService: FavouriteCacheService(),
            movie: movie
        )
        let controller = MovieDetailsViewController(
            viewModel: viewModel
        )

        viewModel.presenter = controller
        controller.title = movie.title

        return controller
    }
}
