//
//  MoviesListView.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 20/10/2023.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesListViewModel
    @EnvironmentObject var router: Router
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        viewModel.viewLoaded()
    }
    
    var body: some View {
        List(viewModel.movies, id: \.id) { movie in
            ZStack {
                MovieCardView(movieEntity: movie)
                    .onTapGesture {
                        router.navigate(from: .moviesList(movie.id))
                    }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("Popular movies")
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(viewModel: MoviesListViewModel(useCases: []))
    }
}
