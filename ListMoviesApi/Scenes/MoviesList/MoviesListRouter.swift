//
//  File.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

protocol MoviesListRouter {
    func showMovieDetails(movie: FetchMovie)
}

final class MoviesListRouterImpl: MoviesListRouter {
    
    weak var controller: UIViewController?
    
    func showMovieDetails(movie: FetchMovie) {
        let vc = MovieDetailsAssembler.assembly(movie: movie)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
