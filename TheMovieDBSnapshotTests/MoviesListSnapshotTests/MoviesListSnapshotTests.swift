//
//  TheMovieDBSnapshotTests.swift
//  TheMovieDBSnapshotTests
//
//  Created by Mustafa Abozaina on 01/01/2024.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import TheMovieDB

final class MoviesListSnapshotTests: XCTestCase {
    
    func test_moviesListViewControllerSuccessState() {
        let exp = expectation(description: #function)
        let moviesListPresenter = MockedMoviesListPresenter()
        let moviesCellsIdentifier = [String(describing: MovieTableViewCell.self)]
        let viewController = MoviesListViewController(presenter: moviesListPresenter,
                                                      cellsIdentifiers: moviesCellsIdentifier)
        moviesListPresenter.delegate = viewController
        viewController.loadViewIfNeeded()
        moviesListPresenter.viewLoaded()

        let timeToRender: TimeInterval = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + timeToRender) {
            self.verifyViewController(viewController, named: "UIKit")
            exp.fulfill()
        }
        wait(for: [exp], timeout: timeToRender + 1)
    }
    
    func test_moviesListSwiftUIView() {
        let exp = expectation(description: #function)
        let viewModel = MockedMoviesListViewModel(useCases: [])
        let moviesListView = MoviesListView(viewModel: viewModel)
        viewModel.movies = buildMockedMoviesList()
        
        let timeToRender: TimeInterval = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + timeToRender) {
            assertSnapshot(of: moviesListView, as: .image, named: "SwiftUI", testName: "MoviesList")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: timeToRender + timeToRender + 1)
    }
    
    private func verifyViewController(_ viewController: UIViewController, named: String) {
        let devices: [String: ViewImageConfig] = ["iPhoneX": .iPhoneX,
                                                  "iPhone8": .iPhone8,
                                                  "iPhoneSe": .iPhoneSe,
                                                  "iPhone13ProMax": .iPhone13ProMax]
        let results = devices.map { device in
            verifySnapshot(matching: viewController,
                           as: .image(on: device.value),
                           named: "\(named)-\(device.key)",
                           testName: "MoviesList")
        }
        results.forEach { XCTAssertNil($0) }
    }
}
