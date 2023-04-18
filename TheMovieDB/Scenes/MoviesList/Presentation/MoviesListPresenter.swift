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
}

class MoviesListPresenter: MoviesListPresenterProtocol, MoviesListEventOuput {
    var delegate: MoviesListPresenterDelegate?
    
    func viewLoaded() {
        // TODO: fire loading movies API
    }
    
    func movieSelected(row: Int) {
        // TODO: Just let the coordinator know
    }
}


