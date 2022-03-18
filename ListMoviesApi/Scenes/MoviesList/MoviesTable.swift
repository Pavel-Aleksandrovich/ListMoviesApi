//
//  MoviesTable.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import UIKit

protocol MoviesTable {
    func configureMovies(movie: PopularMovie)
    var pageClosure: (() -> ())? { get set }
    func sortBy(state: SortState)
}

final class MoviesTableImpl: NSObject, MoviesTable, UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let progressCellIdentifier = "progressCellIdentifier"
        static let heightForRow: CGFloat = 80
    }
    
    private let refreshControl: RefreshControl
    private let viewController: UIViewController
    private let tableView: UITableView
    private let onCellTappedClosure: (FetchMovie) -> ()
    private var movies: [FetchMovie] = []
    private var results: [FetchMovie] = []
    private var isLoading = false
    private var state: SortState = .random
    
    var pageClosure: (() -> ())?
    
    init(tableView: UITableView, viewController: UIViewController, onCellTappedClosure: @escaping (FetchMovie) -> ()) {
        self.tableView = tableView
        self.viewController = viewController
        self.onCellTappedClosure = onCellTappedClosure
        refreshControl = RefreshControl(tableView: tableView)
        super.init()
        configureTableView()
    }
    
    func configureMovies(movie: PopularMovie) {
        movies.append(contentsOf: movie.results)
        chooseState()
    }
    
    func sortBy(state: SortState) {
        self.state = state
        chooseState()
    }
    
    private func chooseState() {
        switch self.state {
        case .id:
            sortById()
        case .title:
            sortByTitle()
        case .random:
            sortByRandom()
        }
    }
    
    private func sortById() {
        results = movies.sorted { $0.id > $1.id  }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func sortByTitle() {
        results = movies.sorted { $0.title < $1.title }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func sortByRandom() {
        results = movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadMoreData()
        }
    }
    
    private func loadMoreData() {
        if !isLoading {
            isLoading = true
            DispatchQueue.global().async {
                sleep(2)
                self.pageClosure?()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MoviesCell
        cell.configure(note: results[indexPath.row])
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        onCellTappedClosure(results[indexPath.row])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MoviesCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let view = viewController.view else { return }
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
