//
//  MoviesListPresenter.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 16/04/2023.
//

import Foundation

protocol MoviesListPresenterDelegate: AnyObject {
    func moviesList(_ movies: [MovieEntity])
}

protocol MoviesListPresenterProtocol {
    var delegate: MoviesListPresenterDelegate? {get set}
    func viewLoaded()
    func movieSelected(row: Int)
}
