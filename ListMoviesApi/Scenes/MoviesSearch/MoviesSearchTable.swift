//
//  MoviesSearchTable.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 15.03.2022.
//

import UIKit

protocol MoviesSearchTable {
    func setPokemons(movie: PopularMovie)
}

final class MoviesSearchTableImpl: NSObject, MoviesSearchTable, UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let heightForRow: CGFloat = 80
    }
    
    private let viewController: UIViewController
    private let tableView: UITableView
    private let onCellTappedClosure: (FetchMovie) -> ()
    private var results: [FetchMovie] = []
    
    init(tableView: UITableView, viewController: UIViewController, onCellTappedClosure: @escaping (FetchMovie) -> ()) {
        self.tableView = tableView
        self.viewController = viewController
        self.onCellTappedClosure = onCellTappedClosure
        super.init()
        configureTableView()
    }
    
    func setPokemons(movie: PopularMovie) {
        results = movie.results
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MoviesSearchCell
        
        cell.configure(note: results[indexPath.row])
        return cell
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

