//
//  MoviesListPresenter.swift
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
        loadMoviesUseCase.mockedMovies = [MockedMovie(name: "Spider Man", id: 1), MockedMovie(name: "Black Widow", id: 2)]
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
    func start(output: ([MovieEntity]) -> ()) {
        numberOfCalls += 1
        output(mockedMovies)
    }
}

private class MockedPresenterDelegate: MoviesListPresenterDelegate {
    var exp: XCTestExpectation?
    func moviesList(_ movies: [MovieEntity]) {
        exp?.fulfill()
    }
}

 struct MockedMovie: MovieEntity {
    var name: String
    var id: Int
    var imageUrl: String?
}

// Presenter functionalities
/*
 1- Excute loadMoviesList useCase
 2- make sure that the output goes to Its delegate
 3- Make necssary presentation Logic
 */
