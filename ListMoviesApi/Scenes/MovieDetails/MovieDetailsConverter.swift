//
//  MovieDetailsConverter.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 19.03.2022.
//

import Foundation

final class MovieDetailsConverter {
    
    func convert(movie: OneMovie) -> MovieDetails {
        
        let genres = movie.genres.map{($0.name)}
        let genre = genres.joined(separator: " ")
        
        let baseUrl = "https://image.tmdb.org/t/p/original"
        
        return MovieDetails(title: movie.title,
                            poster: baseUrl +  movie.posterPath,
                            overview: movie.overview,
                            genre: genre)
    }
}
