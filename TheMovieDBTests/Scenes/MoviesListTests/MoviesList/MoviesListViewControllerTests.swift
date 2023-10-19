//
//  MoviesListViewControllerTests.swift
//  TheMovieDBTests
//
//  Created by Mustafa Abozaina on 16/04/2023.
//

import XCTest
@testable import TheMovieDB

private let moviesDataSource = [
    MockedMovieEntity(id: 1,name: "name1", overview: "overview1", imageUrl: "image-url1"),
    MockedMovieEntity(id:2, name: "name2", overview: "overview2",  imageUrl: "image-url2"),
    MockedMovieEntity(id:3, name: "name3", overview: "overview3", imageUrl: "image-url3"),
]

class MoviesListViewControllerTests: XCTestCase {
    
    func test_loadMovies_shouldBeRenderedOnTable() {
        let exp = XCTestExpectation(description: "Expect to load table cells")

        let viewController = makeSUT()
        viewController.viewDidLoad()
        DispatchQueue.main.async {
            XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), moviesDataSource.count)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_renderingCells_cellsShouldHoldTheCorrectData() {
        let exp = XCTestExpectation(description: "Expect to load table cells")
        let viewController = makeSUT()
        viewController.viewDidLoad()
        
        DispatchQueue.main.async {
            for index in 0..<moviesDataSource.count {
                let cell1 = viewController.tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? TitleSubtitleImageCell
                XCTAssertEqual((cell1 as? MovieTableViewCell)?.titleLabel?.text, moviesDataSource[index].name)
                XCTAssertEqual((cell1 as? MovieTableViewCell)?.subtitleLabel?.text, moviesDataSource[index].overview)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2)
    }
    
    func test_selectingMovie_shouldMoveFromMoviesList() {
       // TODO: 
    }
    
    func makeSUT() -> MoviesListViewController {
        let presenter = MockingMoviesListPresenter()
        let viewController = MoviesListViewController(presenter: presenter, cellsIdentifiers: [MovieTableViewCell.cellIdentifier])
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
       
        self.delegate?.moviesList(moviesDataSource)
    }
}

private struct MockedMovieEntity: MovieEntity {
    var id: Int
    var name: String
    var overview: String?
    var imageUrl: String?
}


// Test Cases
/*
 1- DataSource should rendered correctly
 2- Data of Cell should be same of input data
 3- selection should fire details screen
 4-
 */

