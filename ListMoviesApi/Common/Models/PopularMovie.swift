//
//  PopularMovie.swift
//  ListMoviesApi
//
//  Created by pavel mishanin on 14.03.2022.
//

import Foundation

// MARK: - PopularMovie
struct PopularMovie: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case fr = "fr"
    case ja = "ja"
}


struct MovieParser {
    
    func parseMovieDictionary(dictionary: [String: Any]) -> Result? {
        
        guard let adult = dictionary["adult"] as? Bool,
              let backdrop_path = dictionary["backdrop_path"] as? String,
              let genre_ids = dictionary["genre_ids"] as? [Int],
              let id = dictionary["id"] as? Int,
              let original_language = dictionary["original_language"] as? String,
              let original_title = dictionary["original_title"] as? String,
              let overview = dictionary["overview"] as? String,
              let popularity = dictionary["popularity"] as? Double,
              let poster_path = dictionary["poster_path"] as? String,
              let release_date = dictionary["release_date"] as? String,
              let title = dictionary["title"] as? String,
              let video = dictionary["video"] as? Bool,
              let vote_average = dictionary["vote_average"] as? Double,
              let vote_count = dictionary["vote_count"] as? Int
        else {
            return nil
        }

        let movie: Result = Result(adult: adult, backdropPath: backdrop_path, genreIDS: genre_ids, id: id, originalLanguage: original_language, originalTitle: original_title, overview: overview, popularity: popularity, posterPath: poster_path, releaseDate: release_date, title: title, video: video, voteAverage: vote_average, voteCount: vote_count)

        return movie
    }

}
