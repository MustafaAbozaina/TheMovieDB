//
//  MoviesListView.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 20/10/2023.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesListViewModel
    var movieDetailsFactory: MovieDetailsFactory
    
    init(viewModel: MoviesListViewModel, movieDetailsFactory: MovieDetailsFactory) {
        self.viewModel = viewModel
        self.movieDetailsFactory = movieDetailsFactory
    }
    
    var body: some View {
            List(viewModel.movies, id: \.id) { movie in
                ZStack {
                    MovieCardView(movieEntity: movie)
                    NavigationLink(value: movie.id) {
                        EmptyView()
                    }
                }
            }
            .navigationDestination(for: Int.self, destination: { movieId in
                // Should add here something like (cellMovieSelected)
                let viewModel = movieDetailsFactory.createMovieDetailsSwiftUIScene(movieId: movieId)
                MovieDetailsSwiftUIView(viewModel: viewModel)
            }).buttonStyle(.plain)
            .listStyle(.plain)
            .onAppear {
                viewModel.viewAppeared()
            }
            .navigationBarTitle("Popular movies")
        }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(viewModel: MoviesListViewModel(useCases: []), movieDetailsFactory: ModuleFactory())
    }
}

