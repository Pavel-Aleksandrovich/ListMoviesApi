//
//  MoviesListViewController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import UIKit

final class MoviesListViewControllerImpl: UIViewController, MoviesListViewController {
    
    private enum Constants {
        static let title = "Movies"
    }
    
    private let presenter: MoviesListPresenter
    private let tableView = UITableView()
    private var table: MoviesTable!
    private var page: Int = 1
    
    init(presenter: MoviesListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.onViewAttached(controller: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        configureView()
    }
    
    private func createTableView() {
        table = MoviesTableImpl(tableView: tableView, viewController: self, onCellTappedClosure: { [weak self] movie in
            self?.presenter.showMovieDetails(movie: movie)
        })
        loadMorePokemons()
    }
    
    private func loadMorePokemons() {
        table.pageClosure = {
            self.loadMore()
        }
    }

    func success(movies: PopularMovie) {
        table.setPokemons(movie: movies)
    }
    
    func failure(error: ErrorMessage) {
        print(error)
        self.loadMore()
    }
    
    private func loadMore() {
        page += 1
        presenter.getMovies(page: page)
    }
    
    private func configureView() {
        title = Constants.title
    }
}

