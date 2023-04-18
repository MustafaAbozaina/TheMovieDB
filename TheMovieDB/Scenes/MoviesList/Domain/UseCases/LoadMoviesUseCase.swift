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
    
    func start(output: ([MovieEntity]) -> ()) {
        
    }
    
}
