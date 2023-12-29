//
//  MovieDetailsEntity.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 27/12/2023.
//

import Foundation

protocol MovieDetailsEntity {
    var id: Int {get set}
    var title: String {get set}
    var overview: String? {get set}
    var imageUrl: String? {get set}
}

struct MovieDetails: MovieDetailsEntity {
    var id: Int
    var title: String
    var overview: String?
    var imageUrl: String?
}
