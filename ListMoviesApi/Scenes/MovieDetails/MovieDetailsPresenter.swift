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
    private let id: Int
    private let converter: MovieDetailsConverter
    
    init(interactor: MoviesInteractor, id: Int, converter: MovieDetailsConverter) {
        self.interactor = interactor
        self.id = id
        self.converter = converter
    }
    
    func onViewAttached(controller: MovieDetailsViewController) {
        self.controller = controller
        configureView()
    }
    
    private func configureView() {
        print(id)
        interactor.fetchMovieById(id: id) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movie):
                self.controller?.configure(movie: self.converter.convert(movie: movie))
            }
        }
    }
}

final class MovieDetailsConverter {
    
    func convert(movie: OneMovie) -> MovieDetails {
        let movieDetails = MovieDetails(title: movie.title, poster: "https://image.tmdb.org/t/p/original" +  movie.posterPath, overview: movie.overview, genre: [1])
        
        return movieDetails
    }
}
