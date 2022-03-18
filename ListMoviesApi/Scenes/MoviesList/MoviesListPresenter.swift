//
//  MoviesListPresenter.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

protocol MoviesListPresenter {
    func onViewAttached(controller: MoviesListViewController)
    func showMovieDetails(movie: FetchMovie)
    func getMovies(page: Int)
}

protocol MoviesListViewController: AnyObject {
    func success(movies: PopularMovie)
    func failure(error: ErrorMessage)
}

final class MoviesListPresenterImpl: MoviesListPresenter {
    
    private weak var controller: MoviesListViewController?
    private let router: MoviesListRouter
    private let interactor: MoviesInteractor
    
    init(interactor: MoviesInteractor, router: MoviesListRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAttached(controller: MoviesListViewController) {
        self.controller = controller
    }
    
    func showMovieDetails(movie: FetchMovie) {
        router.showMovieDetails(movie: movie)
    }
    
    func getMovies(page: Int) {
        interactor.getMovies(page: page) { result in
            switch result {
            case .failure(let error):
                self.controller?.failure(error: error)
            case .success(let movies):
                self.controller?.success(movies: movies)
            }
        }
    }
}
