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
    
    let networkManager = NetworkManager()
    private let tableView = UITableView()
    private var table: MoviesTable!
    
    private var offset: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createTableView()
        showPokemons()
    }
    
    private func createTableView() {
        table = MoviesTableImpl(tableView: tableView, viewController: self, onCellTappedClosure: { [weak self] movie in
            self?.showMovieDetails(movie: movie)
        })
    }
    
    func showPokemons() {
        networkManager.getMovies { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movie):
                self.table.setPokemons(movie: movie)
            }
        }
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

