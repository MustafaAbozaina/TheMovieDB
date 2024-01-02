//
//  MoviesListViewModel.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 20/10/2023.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var movies: [MovieEntity] = []
    var useCases: [any UseCase]
    
    init(useCases: [any UseCase]) {
        self.useCases = useCases
    }
    
    func viewLoaded() {
        loadMoviesUseCase?.start() { [weak self] (movies, error) in
            DispatchQueue.main.async {
                self?.movies = (movies as? [Movie]) ?? []
            }
        }
    }
}

extension MoviesListViewModel {
    var loadMoviesUseCase: (any LoadMoviesUseCase)? {
        return self.useCases.filter({$0 is (any LoadMoviesUseCase)}).first as? (any LoadMoviesUseCase)
    }
}
