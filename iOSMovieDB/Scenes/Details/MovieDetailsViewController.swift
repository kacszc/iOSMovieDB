//
//  MovieDetailsViewController.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 03/12/2023.
//

import UIKit
import Combine

protocol MovieDetailsPresenter: AnyObject {
    func updateView(using viewModel: MovieDetailsViewController.ViewModel)
    func setFavouriteState(_ isFavourite: Bool)
}

class MovieDetailsViewController: UIViewController {
    let previewImage = UIImageView()
    let releaseDateLabel = UILabel()
    let ratingLabel = UILabel()
    let favouriteButton = UIButton()
    let overviewTextView = UITextView()

    let viewModel: MovieDetailsViewModelProtocol
    var cancellables: Set<AnyCancellable> = []

    init(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()

        setupActions()        
        viewModel.viewDidLoad()
    }

    private func setupViews() {
        view.backgroundColor = .white
        setupImageView()
        setupFavouriteButton()
        setupReleaseDateLabel()
        setupRatingLabel()
        setupOverviewLabel()
    }

    private func layoutViews() {
        layoutImageView()
        layoutFavouriteButton()
        layoutReleaseDateLabel()
        layoutRatingLabel()
        layoutOverviewLabel()
    }
    
    private func setupImageView() {
        previewImage.clipsToBounds = true
        previewImage.layer.cornerRadius = 16
        view.addSubview(previewImage)
    }

    private func layoutImageView() {
        previewImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            width: 96,
            height: 128
        )
    }

    func setupFavouriteButton() {
        favouriteButton.setImage(
            .init(systemName: "star"),
            for: .normal
        )
        favouriteButton.tintColor = AppColors.yellow

        view.addSubview(favouriteButton)
    }

    func layoutFavouriteButton() {
        favouriteButton.anchorCenterY(to: previewImage)
        favouriteButton.anchor(
            trailing: view.safeAreaLayoutGuide.trailingAnchor,
            paddingRight: 8,
            width: 48,
            height: 48
        )
    }

    func setupReleaseDateLabel() {
        releaseDateLabel.numberOfLines = 0
        releaseDateLabel.font = AppFont.medium
        view.addSubview(releaseDateLabel)
    }

    func layoutReleaseDateLabel() {
        releaseDateLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: previewImage.trailingAnchor,
            trailing: favouriteButton.leadingAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingRight: 8
        )
    }

    func setupRatingLabel() {
        ratingLabel.font = AppFont.medium
        view.addSubview(ratingLabel)
    }

    func layoutRatingLabel() {
        ratingLabel.anchor(
            top: releaseDateLabel.bottomAnchor,
            leading: previewImage.trailingAnchor,
            trailing: favouriteButton.leadingAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingRight: 8
        )
    }

    private func setupOverviewLabel() {
        overviewTextView.isEditable = false
        overviewTextView.font = AppFont.medium
        view.addSubview(overviewTextView)
    }

    private func layoutOverviewLabel() {
        overviewTextView.anchor(
            top: previewImage.bottomAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.trailingAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingBottom: 8,
            paddingRight: 8
        )
    }

    func setupActions() {
        favouriteButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.viewModel.didTapFavouriteButton()
            }
            .store(in: &cancellables)
    }
}

extension MovieDetailsViewController: MovieDetailsPresenter {
    func updateView(using viewModel: 
                    MovieDetailsViewController.ViewModel) {
        overviewTextView.text = viewModel.description
        releaseDateLabel.text = "Release Date: \n\(viewModel.releaseDate)"
        ratingLabel.text = "\(String(format: "%.1f", viewModel.rating)) / 10"
        setFavouriteState(viewModel.isFavourite)

        guard
            let imageURL = viewModel.imageURL
        else {
            return
        }
        previewImage.kf.setImage(with: imageURL)
    }

    func setFavouriteState(_ isFavourite: Bool) {
        let starImage = isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favouriteButton.setImage(
            starImage,
            for: .normal
        )
    }
}

extension MovieDetailsViewController {
    struct ViewModel {
        let imageURL: URL?
        let title: String
        let description: String
        let releaseDate: String
        let rating: Double
        let isFavourite: Bool
    
        init(imageURL: URL?, title: String, description: String, releaseDate: String, rating: Double, isFavourite: Bool) {
            self.imageURL = imageURL
            self.title = title
            self.description = description
            self.releaseDate = releaseDate
            self.isFavourite = isFavourite
            self.rating = rating
        }

        init(using movie: Movie) {
            self.imageURL = movie.imageURL
            self.title = movie.title
            self.description = movie.description
            self.releaseDate = movie.releaseDate
            self.isFavourite = movie.isFavourite
            self.rating = movie.voteAverage
        }
    }
}
