//
//  MoviesSearchRouter.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import UIKit

protocol MoviesSearchRouter {
    func showMovieDetails(id: Int)
}

final class MoviesSearchRouterImpl: MoviesSearchRouter {
    
    weak var controller: UIViewController?
    
    func showMovieDetails(id: Int) {
        let vc = MovieDetailsAssembler.assembly(id: id)
        controller?.navigationController?.pushViewController(vc, animated: false)
    }
}
