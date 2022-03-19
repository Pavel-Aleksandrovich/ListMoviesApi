//
//  NetworkManager.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import Foundation

protocol NetworkManager {
    func fetchPopularMovies(page: String, completion: @escaping(Result<PopularMovie, ErrorMessage>) -> ())
    func searchMovies(query: String, completion: @escaping(Result<PopularMovie, ErrorMessage>) -> ())
    func loadMoviePosterBy(url: String, completed: @escaping(Data) -> ())
    func fetchMovieById(id: String, completion: @escaping(Result<OneMovie, ErrorMessage>) -> ())
}

final class NetworkManagerImpl: NetworkManager {
    
    enum Api: String {
        case popular = "https://api.themoviedb.org/3/movie/popular?api_key=e42ad7e92f09e1e62746935304b34548&page="
        case search = "https://api.themoviedb.org/3/search/movie?api_key=e42ad7e92f09e1e62746935304b34548&query="
    }
    
    private func loadData<T: Decodable>(api: Api, string: String, completion: @escaping(Result<T, ErrorMessage>) -> ()) {
        
        let url = api.rawValue + string
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //             Returns if error exists
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    func fetchPopularMovies(page: String, completion: @escaping(Result<PopularMovie, ErrorMessage>) -> ()) {
        loadData(api: .popular, string: page, completion: completion)
    }
    
    func searchMovies(query: String, completion: @escaping(Result<PopularMovie, ErrorMessage>) -> ()) {
        loadData(api: .search, string: query, completion: completion)
    }
    
    func loadMoviePosterBy(url: String, completed: @escaping(Data) -> ()) {
        let imageURL = URL(string: "https://image.tmdb.org/t/p/original" + url)!
        
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    completed(data)
                }
            }
        }
    }
    
    func fetchMovieById(id: String, completion: @escaping(Result<OneMovie, ErrorMessage>) -> ()) {
        
        let url = "https://api.themoviedb.org/3/movie/" + "\(id)" + "?api_key=e42ad7e92f09e1e62746935304b34548"
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //             Returns if error exists
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(OneMovie.self, from: data)
                completion(.success(response))
            } catch {
                
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}
