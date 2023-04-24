//
//  LoadMoviesRepository.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 19/04/2023.
//

import Foundation

protocol LoadMoviesRepository {
    func load(success: @escaping ([MovieEntity]) -> (), failure: @escaping (Error) -> ())
}
