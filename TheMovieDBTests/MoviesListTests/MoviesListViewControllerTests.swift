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
        let viewController = makeSUT()
        
        let cell1 = viewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? MovieTableViewCell
        let cell2 = viewController.tableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? MovieTableViewCell
        XCTAssertEqual(cell1?.titleLabel?.text, "name1")
        XCTAssertEqual(cell2?.titleLabel?.text, "name2")
    }
    
    func test_selectingMovie_shouldMoveFromMoviesList() {
       // TODO: 
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

extension MockingMoviesListPresenter: MoviesListEventOuput {
    
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

