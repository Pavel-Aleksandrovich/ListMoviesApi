//
//  MoviesTabBarController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 15.03.2022.
//

import UIKit

final class MoviesTabBarController: UITabBarController {
    
    private let moviesList = UINavigationController(rootViewController: MoviesListViewControllerImpl())
    private let moviesSearch = UINavigationController(rootViewController: MoviesSearchViewControllerImpl())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesList.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        moviesSearch.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        viewControllers = [moviesList, moviesSearch]
    }
}
