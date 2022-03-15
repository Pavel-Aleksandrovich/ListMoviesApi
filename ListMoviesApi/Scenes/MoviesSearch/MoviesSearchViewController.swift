//
//  MoviesSearchViewController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 15.03.2022.
//

import UIKit

final class MoviesSearchViewControllerImpl: UIViewController {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let progressCellIdentifier = "progressCellIdentifier"
        static let heightForRow: CGFloat = 80
        static let title = "Movies"
    }
    
    private let networkManager = NetworkManager()
    private let tableView = UITableView()
    private var table: MoviesSearchTable!
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var offset: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createTableView()
        showPokemons()
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter your requiest"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func createTableView() {
        table = MoviesSearchTableImpl(tableView: tableView, viewController: self, onCellTappedClosure: { [weak self] movie in
            self?.showMovieDetails(movie: movie)
        })
    }
    
    func showPokemons() {
    }
    
    private func configureView() {
        title = Constants.title
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor(named: "NavBarGray")
        navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    func showMovieDetails(movie: Result) {
    }
}

extension MoviesSearchViewControllerImpl: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
//        filterArray = animalArray.filter {
//            $0.name.lowercased().contains(searchText.lowercased())
//        }
//        tableView.reloadData()
    }
    
}
