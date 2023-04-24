//
//  LoadMoviesUseCase.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import Foundation

protocol LoadMoviesUseCase: UseCase where Input == Void?, Output == ([MovieEntity]) -> () {
    
}

class DefaultLoadMoviesUseCase: LoadMoviesUseCase {
    let loadMoviesRepository: LoadMoviesRepository?
    
    init(loadMoviesRepository: LoadMoviesRepository?) {
        self.loadMoviesRepository = loadMoviesRepository
    }
    
    func start(output: @escaping ([MovieEntity]) -> ()) {
        self.loadMoviesRepository?.load { movies in
            output(movies)
        } failure: { error in
            
        }
    }
    
}
