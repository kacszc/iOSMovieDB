//
//  MovieListViewModel.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 02/12/2023.
//

import UIKit
import Combine

protocol MovieListViewModelProtocol {
    func viewDidLoad()
    func refreshData()
    func bindTableView(_ tableView: UITableView)
}

class MovieListViewModel: NSObject, MovieListViewModelProtocol {
    weak var presenter: MovieListPresenter?
    private var dataSource: TableDataSourceProvider<Movie>?
    private let cacheService: FavouriteCacheServiceProtocol
    
    var cancellables: Set<AnyCancellable> = []
    var movies: [Movie] = .init()
    var currentPage = 0

    init(
        presenter: MovieListPresenter? = nil,
        cacheService: FavouriteCacheServiceProtocol
    ) {
        self.presenter = presenter
        self.cacheService = cacheService
    }
    
    func viewDidLoad() {
        fetchAndRefresh()
    }

    func fetchAndRefresh() {
        presenter?.setLoaderState(isRunning: true)

        Task {
            currentPage += 1
            do {
                let moviesResult = try await APIProvider().executeRequest(
                    route: MovieListEndpoint(page: currentPage)
                )

                let updatedMovieList = updateAndGetWithFavourites(moviesResult.results)
                movies.append(contentsOf: updatedMovieList)

                await dataSource?.update(using: movies)
            } catch {
                presenter?.displayAlert(with: error.localizedDescription)
            }

            presenter?.setLoaderState(isRunning: false)
        }
    }

    private func updateAndGetWithFavourites(_ fetchedMovies: [Movie]) -> [Movie] {
        let favouriteIds = cacheService.restore()
        var updatedMovieList = [Movie]()

        fetchedMovies.forEach { movie in
            movie.isFavourite = favouriteIds.first(where: { $0 == movie.id }) != nil
            updatedMovieList.append(movie)
        }

        return updatedMovieList
    }

    func bindTableView(_ tableView: UITableView) {
        dataSource = .init(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: MovieCell.identifier,
                    for: indexPath
                ) as? MovieCell
            else {
                return nil
            }

            cell.update(
                using: .init(using: item)
            )

            cell.favouriteSelectionPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] _ in
                    let isFavourite = self?.updateFavouriteFor(item) ?? false
                    cell.updateFavourite(isFavourite)
                })
                .store(in: &cell.cancellables)

            return cell
        })

        dataSource?.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
        tableView.delegate = self
    }

    func refreshData() {
        dataSource?.update(using: movies)

        presenter?.reloadTable()
    }
}

extension MovieListViewModel {
    private func updateFavouriteFor(_ item: Movie) -> Bool {
        guard
            let movie = movies.first(where: { $0.id == item.id })
        else {
            return false
        }
        
        movie.isFavourite.toggle()

        cacheService.changeFor(
            id: movie.id,
            isFavourite: movie.isFavourite
        )
    
        return movie.isFavourite
    }
}

extension MovieListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToDetails(using: movies[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = movies.count - 1
        if indexPath.row == lastIndex {
            fetchAndRefresh()
        }
    }
}
