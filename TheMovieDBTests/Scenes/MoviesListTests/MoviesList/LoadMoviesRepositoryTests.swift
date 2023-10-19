//
//  LoadMoviesRepositoryTests.swift
//  TheMovieDBTests
//
//  Created by Mustafa Abozaina on 19/10/2023.
//

import XCTest
@testable import TheMovieDB


class LoadMoviesRepositoryTests: XCTestCase {

    func test_loadingMovies_shouldLoadedSuccessfully() {
        let exp = expectation(description: #function)
        let remoteDataSource = MockedLoadingMoviesRemoteDataSource()
        let sut = MoviesRepository(dataSources: [remoteDataSource])
        (sut as LoadMoviesRepository).loadMovies(success: { movies in
            exp.fulfill()
        }, failure: { error in
            
        })
        waitForExpectations(timeout: 2)
    }
}

private class MockedLoadingMoviesRemoteDataSource: RemoteDataSource {
    func start(success: @escaping (TheMovieDB.MoviesDBRootDTO<[TheMovieDB.MovieDTO]>) -> (), failure: @escaping (Error?) -> ()) {
        let movies = [movieDTO]
        let root = MoviesDBRootDTO(page: 1, results: movies, totalPages: 3, totalResults: movies.count)
        success(root)
    }
    
}

struct MockingMovie {
    
}

fileprivate let movieDTO = MovieDTO(adult: true, backdropPath: "", genreIDS: nil, id: 1, originalLanguage: "EN", originalTitle: "Spider Man", overview: "Spidee overview", popularity: 6.5, posterPath: "posterpath.com", releaseDate: "2024/1/1", title: "The movie title", video: true, voteAverage: 5.1, voteCount: 200)
