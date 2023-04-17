//
//  MoviesListViewControllerTests.swift
//  TheMovieDBTests
//
//  Created by Mustafa Abozaina on 16/04/2023.
//

import XCTest
@testable import TheMovieDB

class MoviesListViewControllerTests: XCTestCase {
    
    func test_loadMovies_shouldBeRenderedOnTable() {
        let viewController = makeSUT()
         XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_renderingCells_cellsShouldHoldTheCorrectData() {
      
    }
    
    func test_selectingMovie_shouldMoveFromMoviesList() {
      
    }
    
    func makeSUT() -> MoviesListViewController {
        let presenter = MockingMoviesListPresenter()
        let viewController = MoviesListViewController(presenter: presenter)
        presenter.delegate = viewController
        let _ = viewController.view
        return viewController
    }
}

class MockingMoviesListPresenter: MoviesListPresenterProtocol {
    var delegate: MoviesListPresenterDelegate?
 
    func movieSelected(row: Int) {
        
    }
}

extension MockingMoviesListPresenter: MoviesListOuput {
    
    func viewLoaded() {
        let movies = [MockedMovieEntity(name: "name1", id: 1, imageUrl: "image-url"), MockedMovieEntity(name: "name2", id: 1, imageUrl: "image-url")]
        self.delegate?.moviesList(movies)
    }
}

private struct MockedMovieEntity: MovieEntity {
    var name: String
    var id: Int
    var imageUrl: String?
}


// Test Cases
/*
 1- DataSource should rendered correctly
 2- Data of Cell should be same of input data
 3- selection should fire details screen
 4-
 */

