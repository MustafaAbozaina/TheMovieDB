//
//  MovieEntity.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 16/04/2023.
//

import Foundation

protocol MovieEntity {
    var id: Int {get set}
    var name: String {get set}
    var overview: String? {get set}
    var imageUrl: String? {get set}
}

struct Movie: MovieEntity {
    var id: Int
    var name: String
    var overview: String?
    var imageUrl: String?
}
