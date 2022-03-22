//
//  ContainerViewController.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 21.03.2022.
//

import UIKit

enum MenuState {
    case open
    case close
}

final class MoviewContainerViewController: UIViewController {
    
    let moviesList = MoviesListAssembler.assembly()
    let slideMenu = SlideMenuViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createChilds()
    }
    
    private func createChilds() {
        
        addChild(slideMenu)
        view.addSubview(slideMenu.view)
        slideMenu.didMove(toParent: self)
        
        addChild(moviesList)
        view.addSubview(moviesList.view)
        moviesList.didMove(toParent: self)
    }
}
