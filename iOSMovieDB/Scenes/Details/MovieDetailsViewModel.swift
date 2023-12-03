//
//  MovieDetailsViewModel.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    func viewDidLoad()
    func didTapFavouriteButton()
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    weak var presenter: MovieDetailsPresenter?
    private let cacheService: FavouriteCacheServiceProtocol

    var movie: Movie

    init(
        presenter: MovieDetailsPresenter? = nil,
        cacheService: FavouriteCacheServiceProtocol,
        movie: Movie
    ) {
        self.presenter = presenter
        self.cacheService = cacheService
        self.movie = movie
    }

    func viewDidLoad() {
        presenter?.updateView(
            using: .init(using: movie)
        )
    }

    func didTapFavouriteButton() {
        movie.isFavourite = !movie.isFavourite

        cacheService.changeFor(
            id: movie.id,
            isFavourite: movie.isFavourite
        )
        presenter?.setFavouriteState(movie.isFavourite)
    }
}
