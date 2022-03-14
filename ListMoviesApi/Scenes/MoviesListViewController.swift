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
    
    private let tableView = UITableView()
    private var table: MoviesTable!
    
    private var offset: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createTableView()
    }
    
    private func createTableView() {
        table = MoviesTableImpl(tableView: tableView, viewController: self, onCellTappedClosure: { [weak self] url in
        })
    }
    
    func showPokemons(pokemons: Movies) {
        table.setPokemons(pokemons: pokemons)
    }
   
    private func configureView() {
        title = Constants.title
    }
}

