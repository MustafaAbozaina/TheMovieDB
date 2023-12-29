//
//  MovieDetailsDTO.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 26/12/2023.
//

import Foundation

struct MovieDetailsDTO: Decodable {
    var id: Int
    var originalTitle: String?
    var overview: String?
    var backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
    }
}

extension MovieDetailsDTO: ToEntity {
    typealias Entity = MovieDetailsEntity
    func toEntity() -> MovieDetailsEntity {
        let imageBaseURL = "https://image.tmdb.org/t/p/w500"
        return MovieDetails(id: id, title: self.originalTitle ?? "", overview: self.overview, imageUrl: imageBaseURL + (self.backdropPath ?? ""))
        
    }
}
