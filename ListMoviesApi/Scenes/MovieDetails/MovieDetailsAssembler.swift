//
//  MovieDetailsAssembler.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

final class MovieDetailsAssembler {
    
    static func assembly( id: Int) -> UIViewController {
        
        let networkManager = NetworkManagerImpl()
        let interactor = MoviesInteractorImpl(networkManager: networkManager)
        let presenter = MovieDetailsPresenterImpl(interactor: interactor, id: id)
        let controller = MovieDetailsViewControllerImpl(presenter: presenter)
        
        return controller
    }
}
