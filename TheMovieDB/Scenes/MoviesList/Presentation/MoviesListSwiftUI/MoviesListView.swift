//
//  MoviesListView.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 20/10/2023.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.movies, id: \.id) { movie in
                MovieCardView(movieEntity: movie)
                    .padding(.bottom)
            }
            .listStyle(.plain)
            .onAppear {
                viewModel.viewAppeared()
            }
            .navigationBarTitle("Popular movies")
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(viewModel: MoviesListViewModel(useCases: []))
    }
}

