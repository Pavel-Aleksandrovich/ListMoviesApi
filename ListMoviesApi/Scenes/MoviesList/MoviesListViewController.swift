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
    
    private var menuState: MenuState = .close
    private let presenter: MoviesListPresenter
    private let tableView = UITableView()
    private var table: MoviesTable!
    private var page: Int = 1
    let slideMenu = SlideMenuViewController()
    private var sortBarButton = CustomBarButtonItem()
    
    private lazy var menuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(menuBarButtomItemTapped))
    
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
        createSortButton()
        navigationItem.setLeftBarButton(menuBarButtonItem, animated: false)
    }
    
    @objc private func menuBarButtomItemTapped() {
        switch menuState {
        case .close:
            navigationController?.view.frame.origin.x = view.frame.size.width * 0.7
            menuState = .open
            
        case .open:
            navigationController?.view.frame.origin.x = 0
            menuState = .close
        }
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
    
    private func createSortButton() {
        sortBarButton.createSortingButton(viewController: self) { sortState in
            self.table.sortBy(state: sortState)
        }
    }
}
