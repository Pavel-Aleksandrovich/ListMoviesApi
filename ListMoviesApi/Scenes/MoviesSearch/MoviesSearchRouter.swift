//
//  MoviesSearchRouter.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

protocol MoviesSearchRouter {
    func showMovieDetails(movie: Result)
}

final class MoviesSearchRouterImpl: MoviesSearchRouter {
    
    weak var controller: UIViewController?
    
    func showMovieDetails(movie: Result) {
        let vc = MovieDetailsAssembler.assembly(movie: movie)
        controller?.navigationController?.pushViewController(vc, animated: false)
    }
}
