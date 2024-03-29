//
//  LoadMoviesUseCaseTests.swift
//  TheMovieDBTests
//
//  Created by Mustafa Abozaina on 20/04/2023.
//

import XCTest
@testable import TheMovieDB

class LoadMoviesUseCaseTests: XCTestCase {
    
    func test_loadingMovies_shouldSuccess() {
        let exp = expectation(description: #function)
        let loadMoviesRepository = MockedLoadMoviesRepo()
        let sut = DefaultLoadMoviesUseCase(loadMoviesRepository: loadMoviesRepository)
        sut.start { movies, error  in
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    func test_loadingMovies_shouldFail() {
        let exp = expectation(description: #function)
        let loadMoviesRepository = MockedLoadMoviesRepo()
        loadMoviesRepository.error = NSError(domain: "domain", code: 1)
        let sut = DefaultLoadMoviesUseCase(loadMoviesRepository: loadMoviesRepository)
        sut.start { movies, error  in
            if let _ = error {
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 2)
    }
}

private class MockedLoadMoviesRepo: LoadMoviesRepository {
    var movies: [MovieEntity] = []
    var error: Error?
    
    func loadMovies(success: @escaping ([TheMovieDB.MovieEntity]) -> (), failure: @escaping (Error) -> ()) {
        let movieDTO = [MockedMovieDTO(name: "movie name", overview: "movie overView", id: 123, posterImageUrl: "image-url")]
        if let error {
            failure(error)
        } else {
            success(movieDTO)
        }
    }
}

private struct MockedMovieDTO: MovieEntity {
    var name: String
    var imageUrl: String?
    var overview: String?
    var id: Int
    var posterImageUrl: String?
}
