//
//  MovieDTO.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 12/05/2023.
//

import Foundation

struct MovieDTO: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
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

extension MovieDTO: ToEntity {
    func toEntity() -> MovieEntity {
        let imageBaseURL = "https://image.tmdb.org/t/p/w500"
        var fullPath: String?
        if let backdropPath = self.backdropPath {
            fullPath = imageBaseURL + backdropPath
        }
        return Movie(id: self.id ?? -1, name: self.title ?? "",  overview: self.overview, imageUrl: fullPath)
    }
}
