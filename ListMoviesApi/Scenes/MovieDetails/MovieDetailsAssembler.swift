//
//  MovieDetailsAssembler.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

final class MovieDetailsAssembler {
    
    static func assembly(movie: FetchMovie) -> UIViewController {
        
        let networkManager = NetworkManagerImpl()
        let interactor = MoviesInteractorImpl(networkManager: networkManager)
        let presenter = MovieDetailsPresenterImpl(interactor: interactor, movie: movie)
        let controller = MovieDetailsViewControllerImpl(presenter: presenter)
        
        return controller
    }
}
