//
//  VCFactory+MoviesList.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import UIKit

extension ViewControllerFactory {
    
    static func createLoadMoviesUseCase() -> any UseCase {
        let loadMoviesRemoteDataSource = createLoadMoviesRemoteDataSource()
        let moviesRepositoryDataSources = [loadMoviesRemoteDataSource]
        let loadMoviesRepo = MoviesRepository(dataSources: moviesRepositoryDataSources)
        let loadMoviesUseCase = DefaultLoadMoviesUseCase(loadMoviesRepository: loadMoviesRepo)
        return loadMoviesUseCase
    }
    
    static func createMoviesListViewController() -> MoviesListViewController {
        let presenter = MoviesListPresenter(useCases: [createLoadMoviesUseCase()])
        let viewController = MoviesListViewController(presenter: presenter, cellsIdentifiers: [String(describing: MovieTableViewCell.self)])
        presenter.delegate = viewController
        return viewController
    }
    
    static func createMoviesListSwiftUIView() -> MoviesListView {
        let viewModel = MoviesListViewModel(useCases: [createLoadMoviesUseCase()])
        let rootView = MoviesListView(viewModel: viewModel)
        return rootView
    }
    
    static func createLoadMoviesRemoteDataSource() -> LoadMoviesRemoteDataSource {
        let httpClient = URLSession.shared
        let popularMovies = "https://api.themoviedb.org/3/movie/popular"
        let parameters = ["page":1,
                          "include_adult": false,
                          "sort_by": "popularity.desc"] as [String : Any]
        return LoadMoviesRemoteDataSource(network: NetworkManager(httpClient: httpClient),
                                   urlPath: popularMovies,
                                          parameters: parameters,
                                   headers: createApiHeaders(),
                                   httpMethod: .get
                                   
        )
    }
    static func createApiHeaders(apiKey: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTkzZGFkMzg2ZWJiMjc1ZmZmOWNkMzY4NzQwNDU4YiIsInN1YiI6IjY1MzAwNDZkZWRlYjQzMDExYjQ0YTg5MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ZjMq39ACJmuEWlj08Kaq4iJNBkzBk1JETb19lte_ahY") -> [String: String] {
        return ["Authorization": "Bearer \(apiKey)",
                "accept": "application/json"]
    }
}
