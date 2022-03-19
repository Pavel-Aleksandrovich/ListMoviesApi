//
//  MoviesInteractor.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 16.03.2022.
//

import Foundation

protocol MoviesInteractor {
    func getMovies(page: Int, completed: @escaping(Result<PopularMovie, ErrorMessage>) -> ())
    func searchMovies(query: String, completed: @escaping(Result<PopularMovie, ErrorMessage>) -> ())
    func loadMoviePosterBy(url: String, completed: @escaping(Data) -> ())
    func fetchMovieById(id: Int, completion: @escaping(Result<OneMovie, ErrorMessage>) -> ())
}

final class MoviesInteractorImpl: MoviesInteractor {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getMovies(page: Int, completed: @escaping(Result<PopularMovie, ErrorMessage>) -> ()) {
        networkManager.fetchPopularMovies(page: "\(page)", completion: completed)
    }
    
    func searchMovies(query: String, completed: @escaping(Result<PopularMovie, ErrorMessage>) -> ()) {
        networkManager.searchMovies(query: query, completion: completed)
    }
    
    func loadMoviePosterBy(url: String, completed: @escaping(Data) -> ()) {
        networkManager.loadMoviePosterBy(url: url, completed: completed)
    }
    
    func fetchMovieById(id: Int, completion: @escaping(Result<OneMovie, ErrorMessage>) -> ()) {
        networkManager.fetchMovieById(id: "\(id)", completion: completion)
    }
}
