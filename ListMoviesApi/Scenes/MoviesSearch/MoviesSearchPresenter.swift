//
//  MoviesSearchPresenter.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

protocol MoviesSearchPresenter {
    func onViewAttached(controller: MoviesSearchViewController)
    func showMovieDetails(movie: FetchMovie)
    func searchMovies(string: String)
}

protocol MoviesSearchViewController: AnyObject {
    func success(movies: PopularMovie)
    func failure(error: ErrorMessage)
}

final class MoviesSearchPresenterImpl: MoviesSearchPresenter {
    
    private weak var controller: MoviesSearchViewController?
    private let router: MoviesSearchRouter
    private let interactor: MoviesInteractor
    
    init(interactor: MoviesInteractor, router: MoviesSearchRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAttached(controller: MoviesSearchViewController) {
        self.controller = controller
    }
    
    func showMovieDetails(movie: FetchMovie) {
        router.showMovieDetails(movie: movie)
    }
    
    func searchMovies(string: String) {
        interactor.searchMovies(query: string) { result in
            switch result {
            case .failure(let error):
                self.controller?.failure(error: error)
            case .success(let movies):
                self.controller?.success(movies: movies)
            }
        }
    }
}
