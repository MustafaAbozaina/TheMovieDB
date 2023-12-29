//
//  LoadMovieDetailsRepository.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 27/12/2023.
//

import Foundation

protocol LoadMovieDetailsRepository {
    func loadMovieDetails(success: @escaping (MovieDetailsEntity) -> (), failure: @escaping (Error) -> ())
}
