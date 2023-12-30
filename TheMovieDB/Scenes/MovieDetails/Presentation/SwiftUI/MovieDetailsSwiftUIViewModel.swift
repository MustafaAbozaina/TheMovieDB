//
//  MovieDetailsSwiftUIViewModel.swift
//  TheMovieDB
//
//  Created by Mustafa Abozaina on 30/12/2023.
//

import Foundation


class MovieDetailsSwiftUIViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    let useCases: [any UseCase]
    
    init(useCases: [any UseCase]) {
        self.useCases = useCases
    }
   
    func viewAppeared() {
        loadMovieDetailsUseCase?.start() { (movieDetails, err) in
            if let movieDetails = movieDetails as? MovieDetails {
                DispatchQueue.main.async {
                    self.movieDetails = movieDetails
                }
            }
        }
    }
}

extension MovieDetailsSwiftUIViewModel {
    var loadMovieDetailsUseCase: (any LoadMovieDetailsUseCase)?  {
        return useCases.first(where: {$0 is (any LoadMovieDetailsUseCase)}) as? (any LoadMovieDetailsUseCase)
    }
}

