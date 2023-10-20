//
//  Flow.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 17/04/2023.
//

import UIKit
import SwiftUI

protocol Coordinator {
    associatedtype Input
    var navigationController: UINavigationController {get set}
    func start(input: Input)
}

class AppFlowCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(input: (window: UIWindow?, uiType: UIType)) {
        let window = input.window
        let uiType = input.uiType
        var rootViewController: UIViewController?
        if uiType == .swiftui {
            rootViewController = UIHostingController(rootView: ViewControllerFactory.createMoviesListSwiftUIView())
        } else {
            rootViewController = self.navigationController
            initalizeHomeScreen()
        }
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func initalizeHomeScreen(){
        let moviesListCoordinator = MoviesListCoordinator(navigationController: self.navigationController)
        moviesListCoordinator.start()
    }
    
    enum UIType {
        case uikit
        case swiftui
    }
}

