//
//  VCFactory+MovieDetails.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 26/12/2023.
//

import UIKit
import SwiftUI

protocol MovieDetailsFactory {
    func createMovieDetailsScene(movieId: Int) -> UIViewController
    func createMovieDetailsSwiftUIScene(movieId: Int) -> MovieDetailsSwiftUIView 
}

extension ModuleFactory: MovieDetailsFactory {
    func createMovieDetailsSwiftUIScene(movieId: Int) -> MovieDetailsSwiftUIView {
        let useCase = createLoadMovieDetailsUseCase(movieId: movieId)
        let viewModel = MovieDetailsSwiftUIViewModel(useCases: [useCase])
        return MovieDetailsSwiftUIView(viewModel: viewModel)
    }
    
    func createMovieDetailsScene(movieId: Int) -> UIViewController {
        let loadMoviesDetailsUseCase = createLoadMovieDetailsUseCase(movieId: movieId)
        let movieDetailsViewModel = MovieDetailsViewModel(useCases: [loadMoviesDetailsUseCase])
        let movieDetailsViewController = MovieDetailsViewController(viewModel: movieDetailsViewModel)
        return movieDetailsViewController
    }
    
    private func createLoadMovieDetailsUseCase(movieId: Int) -> any UseCase {
        let loadMovieDetailsRemoteDataSource = createLoadMovieDetailsRemoteDataSource(movieId: movieId)
        let movieDetailsRepositoryDataSources = [loadMovieDetailsRemoteDataSource]
        let loadMoviesRepo = MovieDetailsRepository(dataSources: movieDetailsRepositoryDataSources)
        let loadMoviesUseCase = DefaultLoadMovieDetailsUseCase(loadMovieDetailsRepository: loadMoviesRepo)
        return loadMoviesUseCase
    }
    
    private func createLoadMovieDetailsRemoteDataSource(movieId: Int) -> LoadMovieDetailsRemoteDataSource {
        let httpClient = URLSession.shared
        let endpoint = "\(movieId)"
        let parameters: [String: Any]? = nil
        return LoadMovieDetailsRemoteDataSource(network: NetworkManager(httpClient: httpClient),
                                   urlPath: endpoint,
                                          parameters: parameters,
                                   headers: createApiHeaders(),
                                   httpMethod: .get
                                   
        )
    }
}
