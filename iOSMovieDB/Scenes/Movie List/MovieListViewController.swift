//
//  MovieListViewController.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 02/12/2023.
//

import UIKit

protocol MovieListPresenter: AnyObject {
    func navigateToDetails(using movie: Movie)
    func reloadTable()

    func setLoaderState(isRunning: Bool)
    func displayAlert(with message: String)
}

class MovieListViewController: UIViewController {
    private let viewModel: MovieListViewModelProtocol
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        viewModel.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.refreshData()
    }

    private func setupViews() {
        view.backgroundColor = .white

        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        let barButon = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButon, animated: true)
    }

    private func setupLoader() {
        activityIndicator.color = AppColors.gray
    }

    private func setupTableView() {
        tableView.rowHeight = 84
        view.addSubview(tableView)
        
        tableView.anchor(to: view.safeAreaLayoutGuide)
        tableView.register(
            MovieCell.self,
            forCellReuseIdentifier: MovieCell.identifier
        )

        viewModel.bindTableView(tableView)
    }
}

extension MovieListViewController: MovieListPresenter {
    func displayAlert(with message: String) {
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }

    func navigateToDetails(using movie: Movie) {
        navigationController?.pushViewController(
            MovieDetailsModule().build(for: movie),
            animated: true
        )
    }

    func reloadTable() {
        self.tableView.reloadData()
    }

    func setLoaderState(isRunning: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isRunning {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }

            self?.activityIndicator.isHidden = !isRunning
        }
       
    }
}
