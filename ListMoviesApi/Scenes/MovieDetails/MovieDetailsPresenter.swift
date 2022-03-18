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
    func configure(movie: MovieDetails)
}

final class MovieDetailsPresenterImpl: MovieDetailsPresenter {
    
    private weak var controller: MovieDetailsViewController?
    private let interactor: MoviesInteractor
    private var movie: FetchMovie
    
    init(interactor: MoviesInteractor, movie: FetchMovie) {
        self.interactor = interactor
        self.movie = movie
    }
    
    func onViewAttached(controller: MovieDetailsViewController) {
        self.controller = controller
        configureView()
    }
    
    private func configureView() {
        interactor.loadMoviePosterBy(url: movie.posterPath) { data in
            let movieDetails = MovieDetails(title: self.movie.title, imageData: data, overview: self.movie.overview, genre: self.movie.genreIDS)
            self.controller?.configure(movie: movieDetails)
            print(self.movie.voteAverage)
        }
    }
}
