//
//  MovieCell.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 02/12/2023.
//

import UIKit
import Kingfisher
import Combine

class MovieCell: UITableViewCell {
    let previewImage = UIImageView()
    let titleLabel = UILabel()
    let favouriteButton = UIButton()

    var cancellables: Set<AnyCancellable> = []

    public var favouriteSelectionPublisher = PassthroughSubject<Bool, Never>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        layoutViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        cancellables.removeAll()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none

        setupImageView()
        setupTitle()
        setupFavouriteButton()
    }

    private func layoutViews() {
        layoutImageView()
        layoutTitle()
        layoutFavouriteButton()
    }

    private func setupImageView() {
        previewImage.backgroundColor = AppColors.gray
        previewImage.layer.cornerRadius = 4
        previewImage.clipsToBounds = true
        contentView.addSubview(previewImage)
    }

    private func layoutImageView() {
        previewImage.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            paddingTop: 8,
            paddingLeft: 16,
            width: 48,
            height: 64
        )
    }

    private func setupTitle() {
        titleLabel.font = AppFont.medium
        contentView.addSubview(titleLabel)
    }

    private func layoutTitle() {
        titleLabel.anchor(
            leading: previewImage.trailingAnchor,
            trailing: favouriteButton.leadingAnchor,
            paddingLeft: 8,
            paddingRight: 8
        )

        titleLabel.anchorCenterY(to: previewImage)
    }

    private func setupFavouriteButton() {
        favouriteButton.setImage(
            .init(systemName: "star"),
            for: .normal
        )
        favouriteButton.tintColor = AppColors.yellow
        favouriteButton.addTarget(
            self,
            action: #selector(didSelectFavouriteBtn),
            for: .touchUpInside
        )

        contentView.addSubview(favouriteButton)
    }

    @objc private func didSelectFavouriteBtn() {
        favouriteSelectionPublisher.send(true)
    }

    private func layoutFavouriteButton() {
        favouriteButton.anchor(
            trailing: contentView.trailingAnchor,
            paddingRight: 16,
            width: 32,
            height: 32
        )
        favouriteButton.anchorCenterY(to: previewImage)
    }

    public func update(using viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        updateFavourite(viewModel.isFavourite)

        guard
            let imageUrl = viewModel.imageURL
        else {
            return
        }

        previewImage.kf.setImage(with: imageUrl)
    }

    public func updateFavourite(_ isFavourite: Bool) {
        let starImage = isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favouriteButton.setImage(
            starImage,
            for: .normal
        )
    }
}

extension MovieCell {
    struct ViewModel {
        let title: String
        let isFavourite: Bool
        let imageURL: URL?

        init(title: String, isFavourite: Bool) {
            self.title = title
            self.isFavourite = isFavourite
            self.imageURL = nil
        }

        init(using movie: Movie) {
            self.title = movie.title
            self.isFavourite = movie.isFavourite
            self.imageURL = movie.imageURL
        }
    }
}
