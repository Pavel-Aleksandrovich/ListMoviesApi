//
//  MoviesTabBarController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 15.03.2022.
//

import UIKit

final class MoviesTabBarController: UITabBarController {
    
    private let moviesSearch = MoviesSearchAssembler.assembly()
    private let movieContainer = MoviewContainerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieContainer.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        moviesSearch.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        viewControllers = [movieContainer, moviesSearch]
    }
}
