//
//  MoviesInteractor.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import Foundation

protocol MoviesInteractor {
    func getMovies(page: Int, completed: @escaping(GetResult) -> ())
    func searchMovies(query: String, completed: @escaping(GetResult) -> ())
}

final class MoviesInteractorImpl: MoviesInteractor {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getMovies(page: Int, completed: @escaping(GetResult) -> ()) {
        networkManager.getMovies(page: page) { result in
            switch result {
            case .failure(let error):
                completed(.failure(error))
            case .success(let movie):
                completed(.success(movie))
            }
        }
    }
    
    func searchMovies(query: String, completed: @escaping(GetResult) -> ()) {
        networkManager.searchMovies(query: query) { result in
            switch result {
            case .failure(let error):
                completed(.failure(error))
            case .success(let movies):
                completed(.success(movies))
            }
        }
    }
}
