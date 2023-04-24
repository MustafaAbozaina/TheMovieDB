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
    var useCases: [any UseCase]
    init(useCases: [any UseCase]) {
        self.useCases = useCases
    }
    
    func viewLoaded() {
        // TODO: fire loading movies API
    }
    
    func movieSelected(row: Int) {
        // TODO: Just let the coordinator know
    }
}

extension MoviesListPresenter {
    var loadMoviesUseCase: (any LoadMoviesUseCase)? {
        return self.useCases.filter({$0 is (any LoadMoviesUseCase)}).first as? (any LoadMoviesUseCase)
    }
    
    func loadMovies() {
        loadMoviesUseCase?.start(output: { movies, error  in
            guard let movies else {
                self.showError(error)
                return
            }
            self.delegate?.moviesList(movies)
        })
    }
    
    func showError(_ error: Error?) {
        // if let error 
    }
}
