//
//  MoviesSearchViewController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 15.03.2022.
//

import UIKit

final class MoviesSearchViewControllerImpl: UIViewController {
    
    private enum Constants {
        static let title = "Movies"
    }
    
    private let networkManager = NetworkManager()
    private let tableView = UITableView()
    private var table: MoviesSearchTable!
    private var searchBar: MovieSearchBar!
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createTableView()
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        searchBar = MovieSearchBar(searchController: searchController, view: self, searchResultClosure: { string in
            self.showPokemons(string: string)
        })
    }
    
    private func createTableView() {
        table = MoviesSearchTableImpl(tableView: tableView, viewController: self, onCellTappedClosure: { [weak self] movie in
        })
    }
    
    func showPokemons(string: String) {
        networkManager.searchMovies(query: string) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movies):
                self.table.setPokemons(movie: movies)
                print(movies.page)
            }
        }
    }
    
    private func configureView() {
        title = Constants.title
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor(named: "NavBarGray")
        navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
}
