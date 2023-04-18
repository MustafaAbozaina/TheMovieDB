//
//  Flow.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 17/04/2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    func start()
}

class AppFlowCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
       initalizeHomeScreen()
    }
    
    private func initalizeHomeScreen(){
        // If login
        let moviesListCoordinator = MoviesListCoordinator(navigationController: self.navigationController)
        moviesListCoordinator.start()
    }
}

