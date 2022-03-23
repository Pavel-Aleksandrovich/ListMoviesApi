//
//  MoviesTabBarController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 15.03.2022.
//

import UIKit

final class MoviesTabBarController: UITabBarController {
    
    private let moviesSearch = MoviesSearchAssembler.assembly()
    private let moviesList = MoviesListAssembler.assembly()
    private let movieSettings = UINavigationController(rootViewController: MovieSettingsViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesList.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        moviesSearch.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        movieSettings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "heart"))
        
        viewControllers = [moviesList, moviesSearch, movieSettings]
    }
}
