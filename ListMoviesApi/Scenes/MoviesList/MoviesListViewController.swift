//
//  MoviesListViewController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import UIKit

final class MoviesListViewControllerImpl: UIViewController {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let progressCellIdentifier = "progressCellIdentifier"
        static let heightForRow: CGFloat = 80
        static let title = "Movies"
    }
    
    private let networkManager = NetworkManager()
    private let tableView = UITableView()
    private var table: MoviesTable!
    private var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        configureView()
    }
    
    private func createTableView() {
        table = MoviesTableImpl(tableView: tableView, viewController: self, onCellTappedClosure: { [weak self] movie in
            self?.showMovieDetails(movie: movie)
        })
        loadMorePokemons()
    }
    
    private func loadMorePokemons() {
        table.pageClosure = {
            self.loadMore()
        }
    }

    
    func showPokemons(page: Int) {
        networkManager.getMovies(page: page) { result in
            switch result {
            case .failure(let error):
                print(error)
                self.loadMore()
            case .success(let movie):
                self.table.setPokemons(movie: movie)
            }
        }
    }
    
    private func loadMore() {
        page += 1
        showPokemons(page: page)
    }
    
    private func configureView() {
        title = Constants.title
    }
    
    func showMovieDetails(movie: Result) {
        let vc = MovieDetailsViewControllerImpl()
        vc.configure(pokemon: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
}

