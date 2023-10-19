//
//  MoviesListPresenterTests.swift
//  TheMovieDBTests
//
//  Created by Mustafa Abozaina on 18/04/2023.
//

import XCTest
@testable import TheMovieDB

class MoviesListPresenterTests: XCTestCase {
    
    func test_excuteLoadMoviesUseCase_shouldCallTheUseCase() {
        let loadMoviesUseCase = MockedLoadMoviesUseCase()
        let sut = MoviesListPresenter(useCases: [loadMoviesUseCase])
        
        sut.loadMovies()
        
        XCTAssertEqual(loadMoviesUseCase.numberOfCalls, 1)
    }
    
    func test_excuteLoadMoviestUseCase_shouldDeliverDataToDelegate() {
        let exp = expectation(description: #function)
        let loadMoviesUseCase = MockedLoadMoviesUseCase()
        loadMoviesUseCase.mockedMovies = [MockedMovie(id: 2, name: "Spider Man", overview: "overview1"), MockedMovie(id: 1, name: "super man", overview: "overview2"), MockedMovie(id: 3, name: "Black Widow", overview: "overview2")]
        let sut = MoviesListPresenter(useCases: [loadMoviesUseCase])
        let presenterDelegate = MockedPresenterDelegate()
        sut.delegate = presenterDelegate
        presenterDelegate.exp = exp
        
        sut.loadMovies()
        waitForExpectations(timeout: 2)
    }
    
    func test_excuteLoadMoviesUseCase_shouldHandleFailure() {
        //TODO:
    }
}

private class MockedLoadMoviesUseCase: LoadMoviesUseCase {
    var numberOfCalls = 0
    var mockedMovies: [MockedMovie] = []
    func start(output: ([MovieEntity]?, Error?) -> ()) {
        numberOfCalls += 1
        output(mockedMovies, nil)
    }
}

private class MockedPresenterDelegate: MoviesListPresenterDelegate {
    var exp: XCTestExpectation?
    func moviesList(_ movies: [MovieEntity]) {
        exp?.fulfill()
    }
}

struct MockedMovie: MovieEntity {
    var id: Int
    var name: String
    var overview: String?
    var imageUrl: String?
}

// Presenter functionalities
/*
 1- Excute loadMoviesList useCase
 2- make sure that the output goes to Its delegate
 3- Make necssary presentation Logic
 */
