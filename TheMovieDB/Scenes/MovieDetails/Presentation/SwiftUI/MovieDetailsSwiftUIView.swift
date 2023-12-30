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
                RemoteImage(urlPath: viewModel.movieDetails?.imageUrl)
                    .scaledToFill()
                    .frame(height: Constants.imageHeight)
                    .frame(maxWidth: 1) // prevent image cross the boundaries
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
        .padding([.leading, .trailing])
        .onAppear {
            viewModel.viewAppeared()
        }
    }
    
    struct Constants {
        static let bottomTextPadding = 1.0
        static let imageHeight = 340.0
    }
}
