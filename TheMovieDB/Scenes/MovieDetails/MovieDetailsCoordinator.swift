//
//  MovieDetailsCoordinator.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 26/12/2023.
//

import UIKit

class MovieDetailsCoordinator: Coordinator {
    var navigationController: UINavigationController
    let movieDetailsFactory: MovieDetailsFactory
    init(navigationController: UINavigationController, movieDetailsFactory: MovieDetailsFactory) {
        self.navigationController = navigationController
        self.movieDetailsFactory = movieDetailsFactory
    }
    
    func start(input: Int) {
        let movieId = input
        let moviesListViewController = movieDetailsFactory.createMovieDetailsScene(movieId: movieId)
        self.navigationController.pushViewController(moviesListViewController, animated: true)
    }
}
