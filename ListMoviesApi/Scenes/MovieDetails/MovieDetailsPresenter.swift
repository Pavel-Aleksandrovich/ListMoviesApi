//
//  MovieDetailsPresenter.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

protocol MovieDetailsPresenter {
    func onViewAttached(controller: MovieDetailsViewController)
}

protocol MovieDetailsViewController: AnyObject {
    func configure(movie: Result)
}

final class MovieDetailsPresenterImpl: MovieDetailsPresenter {
    
    private weak var controller: MovieDetailsViewController?
    private let interactor: MoviesInteractor
    private var movie: Result
    
    init(interactor: MoviesInteractor, movie: Result) {
        self.interactor = interactor
        self.movie = movie
    }
    
    func onViewAttached(controller: MovieDetailsViewController) {
        self.controller = controller
        configureView()
    }
    
    private func configureView() {
        controller?.configure(movie: movie)
    }
}
