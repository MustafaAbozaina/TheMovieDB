//
//  MovieDetailsSwiftUIView.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 30/12/2023.
//

import SwiftUI

struct MovieDetailsSwiftUIView: View {
    @ObservedObject var viewModel: MovieDetailsSwiftUIViewModel

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                moviePoster
                movieFooter
            }
        }
        .padding([.leading, .trailing])
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.viewAppeared()
        }
    }
    
    private var moviePoster: some View {
        RemoteImage(urlPath: viewModel.movieDetails?.imageUrl)
            .scaledToFill()
            .frame(height: Constants.posterHeight)
            .frame(maxWidth: 1) // prevent image crossing the boundaries
    }
    
    private var movieFooter: some View {
        ForEach([viewModel.movieDetails?.title ?? "",
                 viewModel.movieDetails?.overview ?? ""], id: \.self) { text in
            HStack {
                Text(text)
                Spacer()
            }
            .padding(.bottom, Constants.bottomTextPadding)
        }
    }
}

private extension MovieDetailsSwiftUIView {
    struct Constants {
        static let bottomTextPadding = 1.0
        static let posterHeight = 340.0
    }
}
