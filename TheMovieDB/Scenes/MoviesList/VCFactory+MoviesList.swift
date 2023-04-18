//
//  VCFactory+MoviesList.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import UIKit

extension ViewControllerFactory {
    static func createMoviesListViewController() -> MoviesListViewController {
        let presenter = MoviesListPresenter(useCases: [])
        let viewController = MoviesListViewController(presenter: presenter)
        
        return viewController
    }
}
