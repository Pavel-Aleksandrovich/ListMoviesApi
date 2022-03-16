//
//  MoviesListAssembler.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

final class MoviesListAssembler {
    
    static func assembly() -> UIViewController {
        
        let router = MoviesListRouterImpl()
        let networkManager = NetworkManager()
        let interactor = MoviesInteractorImpl(networkManager: networkManager)
        let presenter = MoviesListPresenterImpl(interactor: interactor, router: router)
        let controller = MoviesListViewControllerImpl(presenter: presenter)
        router.controller = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
