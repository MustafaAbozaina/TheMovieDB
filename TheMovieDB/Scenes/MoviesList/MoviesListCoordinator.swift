//
//  MoviesListCoordinator.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import UIKit

class MoviesListCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let moviesListViewController = ViewControllerFactory.createMoviesListViewController()
        self.navigationController.pushViewController(moviesListViewController, animated: false)
    }
}
