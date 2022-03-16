//
//  MoviesSearchViewController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 15.03.2022.
//

import UIKit

final class MoviesSearchViewControllerImpl: UIViewController, MoviesSearchViewController {
    
    private enum Constants {
        static let title = "Movies"
    }
    
    private let presenter: MoviesSearchPresenter
    private let tableView = UITableView()
    private var table: MoviesSearchTable!
    private var searchBar: MovieSearchBar!
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(presenter: MoviesSearchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.onViewAttached(controller: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createTableView()
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        searchBar = MovieSearchBar(searchController: searchController, view: self, searchResultClosure: { string in
            self.presenter.searchMovies(string: string)
        })
    }
    
    func success(movies: PopularMovie) {
        table.setPokemons(movie: movies)
    }
    
    func failure(error: ErrorMessage) {
        print(error)
    }
    
    private func createTableView() {
        table = MoviesSearchTableImpl(tableView: tableView, viewController: self, onCellTappedClosure: { [weak self] movie in
            self?.presenter.showMovieDetails(movie: movie)
        })
    }
    
    private func configureView() {
        title = Constants.title
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor(named: "NavBarGray")
        navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
}
