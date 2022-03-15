//
//  NetworkManager.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import Foundation

enum ObtainResult {
    case success(Posters)
    case failure(ErrorMessage)
}

enum GetResult {
    case success(PopularMovie)
    case failure(ErrorMessage)
}

final class NetworkManager {
    
    private let baseUrl = "https://image.tmdb.org/t/p/"
    private let size = "original"
    
    func getPokemons(posterPath: String, completed: @escaping(ObtainResult) -> ()) {
        
        let endpoint = baseUrl + size + posterPath
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Returns if error exists
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Posters.self, from: data)
                completed(.success(response))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    // token 13f80f74ffa9f05c8bb57ddd1eab91bad1465460
//    + "&page=\(page)"
    private let baseKey = "https://api.themoviedb.org/3/movie/popular?api_key=e42ad7e92f09e1e62746935304b34548"
    
    func getMovies(page: Int = 29, completed: @escaping(GetResult) -> ()) {
        
        let endpoint = baseKey 
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Returns if error exists
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(PopularMovie.self, from: data)
                completed(.success(response))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
}
