//
//  MoviesListCoordinator.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import UIKit

class DefaultMoviesListCoordinator: MoviesListCoordinator {
    var navigationController: UINavigationController
    let moviesListFactory: MoviesListFactory
    var movieSelectedAction: ((_ id: Int) -> ())?
    
    init(navigationController: UINavigationController, moviesListFactory: MoviesListFactory, movieSelected: ((_ id: Int) -> ())? = nil ) {
        self.navigationController = navigationController
        self.moviesListFactory = moviesListFactory
        movieSelectedAction = movieSelected
    }
    
    func start(input: Void? = nil) {
        let moviesListViewController = moviesListFactory.createMoviesListViewController(coordinator: self)
        self.navigationController.pushViewController(moviesListViewController, animated: true)
    }
    
    func movieSelected(id: Int) {
        self.movieSelectedAction?(id)
    }
}

protocol MoviesListCoordinator: Coordinator {
    func movieSelected(id: Int)
}
