//
//  VCFactory+MoviesList.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import UIKit

extension ModuleFactory: MoviesListFactory {
    
    private func createLoadMoviesUseCase() -> any UseCase {
        let loadMoviesRemoteDataSource = createLoadMoviesRemoteDataSource()
        let moviesRepositoryDataSources = [loadMoviesRemoteDataSource]
        let loadMoviesRepo = MoviesRepository(dataSources: moviesRepositoryDataSources)
        let loadMoviesUseCase = DefaultLoadMoviesUseCase(loadMoviesRepository: loadMoviesRepo)
        return loadMoviesUseCase
    }
    
    func createMoviesListViewController(coordinator: any MoviesListCoordinator) -> UIViewController {
         let presenter = MoviesListPresenter(useCases: [createLoadMoviesUseCase()], coordinator: coordinator)
        let viewController = MoviesListViewController(presenter: presenter, cellsIdentifiers: [String(describing: MovieTableViewCell.self)])
        presenter.delegate = viewController
        return viewController
    }
    
      func createMoviesListSwiftUIView() -> RootNavigationStack<MoviesListView> {
          let viewModel = MoviesListViewModel(useCases: [createLoadMoviesUseCase()])
          let rootView = MoviesListView(viewModel: viewModel, movieDetailsFactory: self)
          let mainNavigationStack = RootNavigationStack(rootView: rootView)
        return mainNavigationStack
    }
    
    private func createLoadMoviesRemoteDataSource() -> LoadMoviesRemoteDataSource {
        let httpClient = URLSession.shared
        let endpoint = "popular"
        let parameters = ["page":1,
                          "include_adult": false,
                          "sort_by": "popularity.desc"] as [String : Any]
        return LoadMoviesRemoteDataSource(network: NetworkManager(httpClient: httpClient),
                                   urlPath: endpoint,
                                          parameters: parameters,
                                   headers: createApiHeaders(),
                                   httpMethod: .get
        )
    }
}

protocol MoviesListFactory {
    func createMoviesListViewController(coordinator: any MoviesListCoordinator) -> UIViewController
    func createMoviesListSwiftUIView() -> RootNavigationStack<MoviesListView>
}

protocol SwiftUICoordinator {
    
}
