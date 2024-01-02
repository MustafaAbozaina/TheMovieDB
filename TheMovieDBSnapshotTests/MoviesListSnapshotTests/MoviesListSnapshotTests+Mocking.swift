//
//  MoviesListSnapshotTests+Helpers.swift
//  TheMovieDBSnapshotTests
//
//  Created by Mustafa Abozaina on 02/01/2024.
//

import Foundation
import SwiftUI
@testable import TheMovieDB


class MockedMoviesListPresenter: MoviesListPresenterProtocol, MoviesListEventOuput {
    var delegate: MoviesListPresenterDelegate?
    func viewLoaded() {
        self.delegate?.moviesList(buildMockedMoviesList())
    }
    func movieSelected(row: Int) {}
}

class MockedMoviesListViewModel: MoviesListViewModel {}

func buildMockedMoviesList() -> [MovieEntity] {
    let overviews = dummyLongTexts
    var moviesList: [MockedMovie] = []
    let imagesNames = ["sRLC052ieEzkQs9dEtPMfFxYkej.jpg",
                       "sRLC052ieEzkQs9dEtPMfFxYkej.jpg",
                       "sRLC052ieEzkQs9dEtPMfFxYkej.jpg"]
    let baseImageUrl = "https://image.tmdb.org/t/p/w500/"
    for i in 0..<imagesNames.count {
        moviesList.append(MockedMovie(id: i, name: "movie\(i+1)", overview: overviews[i], imageUrl: baseImageUrl + imagesNames[i]))
    }
    return moviesList
}

struct MockedMovie: MovieEntity {
    var id: Int
    var name: String
    var overview: String?
    var imageUrl: String?
}

class DummyMoviesListCoordinator: MoviesListCoordinator {
    var navigationController: UINavigationController
    init(navigationController: UINavigationController = UINavigationController()) {self.navigationController = navigationController}
    func start(input: Void?) {}
    func movieSelected(id: Int) {}
}

let dummyLongTexts = ["Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.",
                      "p one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a",
                      "g the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolo"]
