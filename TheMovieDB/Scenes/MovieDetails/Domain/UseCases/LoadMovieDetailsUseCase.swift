//
//  LoadMovieDetailsUseCase.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 27/12/2023.
//

import Foundation

protocol LoadMovieDetailsUseCase: UseCase where Input == Void?, Output == ( (_ success: MovieDetailsEntity?, _ failure: Error?) -> () ) {
}

class DefaultLoadMovieDetailsUseCase: LoadMovieDetailsUseCase {
    let loadMovieDetailsRepository: LoadMovieDetailsRepository?
    
    init(loadMovieDetailsRepository: LoadMovieDetailsRepository?) {
        self.loadMovieDetailsRepository = loadMovieDetailsRepository
    }
    
    func start(output: @escaping (MovieDetailsEntity?, Error?) -> ()) {
        self.loadMovieDetailsRepository?.loadMovieDetails { movieDetails in
            output(movieDetails, nil)
        } failure: { error in
            output(nil, error)
        }
    }
}
