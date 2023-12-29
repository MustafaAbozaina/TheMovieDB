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
    var coordinator: any MoviesListCoordinator
    private var movies: [MovieEntity] = []
    init(useCases: [any UseCase], coordinator: any MoviesListCoordinator) {
        self.useCases = useCases
        self.coordinator = coordinator
    }
    
    func viewLoaded() {
        loadMoviesUseCase?.start() { [weak self] (movies, error) in
            self?.movies = movies ?? []
            self?.delegate?.moviesList(movies ?? [])
        }
    }
    
    func movieSelected(row: Int) {
        self.coordinator.movieSelected(id: movies[row].id)
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
