//
//  LoadMoviesUseCase.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import Foundation

protocol LoadMoviesUseCase: UseCase where Input == Void?, Output == ( (_ success: [MovieEntity]?, _ failure: Error?) -> () ) {
}

class DefaultLoadMoviesUseCase: LoadMoviesUseCase {
    let loadMoviesRepository: LoadMoviesRepository?
    
    init(loadMoviesRepository: LoadMoviesRepository?) {
        self.loadMoviesRepository = loadMoviesRepository
    }
    
    func start(output: @escaping ([MovieEntity]?, Error?) -> ()) {
        self.loadMoviesRepository?.loadMovies { movies in
            output(movies, nil)
        } failure: { error in
            output(nil, error)
        }
    }
}
