//
//  NetworkManager.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import Foundation

enum GetResult {
    case success(PopularMovie)
    case failure(ErrorMessage)
}

final class NetworkManager {
    
    // token 13f80f74ffa9f05c8bb57ddd1eab91bad1465460
//    + "&page=\(page)"
    private let baseKey = "https://api.themoviedb.org/3/movie/popular?api_key=e42ad7e92f09e1e62746935304b34548"
    
    func getMovies(page: Int, completed: @escaping(GetResult) -> ()) {
        
        let endpoint = baseKey + "&page=\(page)"
        
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
    
    let mainUrl = "https://api.themoviedb.org/3/search/movie?api_key=e42ad7e92f09e1e62746935304b34548"
    
    func searchMovies(query: String, page: Int = 1, completed: @escaping(GetResult) -> ()) {
        
        let endpoint = mainUrl + "&query=\(query)" 
        
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
