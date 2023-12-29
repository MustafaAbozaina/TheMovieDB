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
    init(navigationController: UINavigationController, moviesListFactory: MoviesListFactory) {
        self.navigationController = navigationController
        self.moviesListFactory = moviesListFactory
    }
    
    func start(input: Void? = nil) {
        let moviesListViewController = moviesListFactory.createMoviesListViewController(coordinator: self)
        self.navigationController.pushViewController(moviesListViewController, animated: true)
    }
    
    func movieSelected(id: Int) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController, movieDetailsFactory: ModuleFactory())
        movieDetailsCoordinator.start(input: id)
    }
}

protocol MoviesListCoordinator: Coordinator {
    func movieSelected(id: Int)
}
