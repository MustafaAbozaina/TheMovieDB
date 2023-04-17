//
//  MovieEntity.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 16/04/2023.
//

import Foundation

protocol MovieEntity {
    var name: String {get set}
    var id: Int {get set}
    var imageUrl: String? {get set}
}

struct Movie: MovieEntity {
    var name: String
    var id: Int
    var imageUrl: String?
}
