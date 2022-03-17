//
//  MoviesListViewController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import UIKit

enum SortState {
    case id
    case title
    case random
}

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
        createSortingButton()
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
        table.configureMovies(movie: movies)
    }
    
    func failure(error: ErrorMessage) {
        print(error)
        self.loadMore()
    }
    
    private func loadMore() {
        presenter.getMovies(page: page)
        page += 1
    }
    
    private func createSortingButton() {
        let sortingButton = UIBarButtonItem(title: "Sorting by: Random", style: .done, target: self, action: #selector(sortingButtonTapped))
        navigationItem.rightBarButtonItem = sortingButton
    }
    
    @objc private func sortingButtonTapped() {
        let alert = UIAlertController(title: "Sorting by:", message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Id", style: .default) {_ in
            self.table.sortBy(state: .id)
            self.navigationItem.rightBarButtonItem?.title = "Sorting by: Id"
        }
        let cameraAction = UIAlertAction(title: "Title", style: .default) {_ in
            self.table.sortBy(state: .title)
            self.navigationItem.rightBarButtonItem?.title = "Sorting by: Title"
        }
        let randomAction = UIAlertAction(title: "Random", style: .default) {_ in
            self.table.sortBy(state: .random)
            self.navigationItem.rightBarButtonItem?.title = "Sorting by: Random"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(randomAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

