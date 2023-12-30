//
//  MovieDetailsViewModel.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 27/12/2023.
//

import Foundation

class MovieDetailsViewModel {
    let useCases: [any UseCase]
    var completionResult: ((MovieDetailsEntity) -> ()) = {_ in}
    
    private var movieDetails: MovieDetailsEntity? = nil {
        willSet {
            if let newValue {
                completionResult(newValue)
            }
        }
    }
    
    init(useCases: [any UseCase]) {
        self.useCases = useCases
    }
    
    func viewDidLoaded() {
        loadMovieDetailsUseCase?.start() { (movieDetails, err) in
            self.movieDetails = movieDetails
        }
    }
    
    func binding(result: @escaping (MovieDetailsEntity) -> ()) {
        completionResult = result
    }
}

extension MovieDetailsViewModel {
    var loadMovieDetailsUseCase: (any LoadMovieDetailsUseCase)?  {
        return useCases.first(where: {$0 is (any LoadMovieDetailsUseCase)}) as? (any LoadMovieDetailsUseCase)
    }
}
