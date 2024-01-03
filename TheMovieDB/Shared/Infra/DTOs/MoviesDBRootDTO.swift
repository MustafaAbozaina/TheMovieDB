//
//  MoviesDBRootDTO.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 12/05/2023.
//

import Foundation

// MARK: - MoviesDBRootModel
struct MoviesDBRootDTO<T: Decodable>: Decodable {
    let page: Int?
    let results: T?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

