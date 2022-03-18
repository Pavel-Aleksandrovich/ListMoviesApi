//
//  MoviesSearchAssembler.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

final class MoviesSearchAssembler {
    
    static func assembly() -> UIViewController {
        
        let router = MoviesSearchRouterImpl()
        let networkManager = NetworkManagerImpl()
        let interactor = MoviesInteractorImpl(networkManager: networkManager)
        let presenter = MoviesSearchPresenterImpl(interactor: interactor, router: router)
        let controller = MoviesSearchViewControllerImpl(presenter: presenter)
        router.controller = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
