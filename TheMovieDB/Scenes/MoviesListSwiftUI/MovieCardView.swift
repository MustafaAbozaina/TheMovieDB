//
//  MovieItemView.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 19/10/2023.
//

import SwiftUI
import Kingfisher

struct MovieCardView: View {
    let movieEntity: MovieEntity
    var body: some View {
        VStack(alignment: .leading) {
            movieImage
            Text(movieEntity.name)
                .font(.headline)
            Text(movieEntity.overview ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    @ViewBuilder
    var movieImage: some View {
        if let imageUrl = URL(string: movieEntity.imageUrl ?? "") {
            KFImage(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
        }
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movieEntity: Movie(id: 1, name: "movie1", overview: "overview1", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Flag_of_Palestine.svg/800px-Flag_of_Palestine.svg.png"))
    }
}
