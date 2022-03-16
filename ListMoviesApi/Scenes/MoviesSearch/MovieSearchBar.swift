//
//  MovieSearchBar.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

final class MovieSearchBar: NSObject, UISearchResultsUpdating {
    
    private enum Constants {
        static let placeholder = "Enter text"
    }
    
    private let searchController: UISearchController
    private let view: UIViewController
    private let searchResultClosure: (String) -> ()
    
    init(searchController: UISearchController, view: UIViewController, searchResultClosure: @escaping (String) -> ()) {
        self.searchController = searchController
        self.view = view
        self.searchResultClosure = searchResultClosure
        super.init()
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.placeholder
        view.navigationItem.searchController = searchController
        view.definesPresentationContext = true
        view.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchResultClosure(searchController.searchBar.text!)
    }
}
