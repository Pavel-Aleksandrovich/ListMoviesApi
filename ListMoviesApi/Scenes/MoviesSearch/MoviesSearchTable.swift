//
//  MoviesSearchTable.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 15.03.2022.
//

import UIKit

protocol MoviesSearchTable {
    func setPokemons(movie: PopularMovie)
    var pageClosure: (() -> ())? { get set }
}

final class MoviesSearchTableImpl: NSObject, MoviesSearchTable, UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let progressCellIdentifier = "progressCellIdentifier"
        static let heightForRow: CGFloat = 80
        static let title = "Pokemons"
    }
    
    private let refreshControl: RefreshControl
    private let viewController: UIViewController
    private let tableView: UITableView
    private let onCellTappedClosure: (Result) -> ()
    private var movies: [PopularMovie] = []
    private var results: [Result] = []
    private var isLoading = false
    
    var pageClosure: (() -> ())?
    
    init(tableView: UITableView, viewController: UIViewController, onCellTappedClosure: @escaping (Result) -> ()) {
        self.tableView = tableView
        self.viewController = viewController
        self.onCellTappedClosure = onCellTappedClosure
        refreshControl = RefreshControl(tableView: tableView)
        super.init()
        configureTableView()
    }
    
    func setPokemons(movie: PopularMovie) {
        results = movie.results
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MoviesSearchCell
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
//        onCellTappedClosure(results[indexPath.row])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MoviesSearchCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
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

