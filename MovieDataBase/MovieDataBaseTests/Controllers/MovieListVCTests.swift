//
//  MovieListVCTests.swift
//  MovieDataBaseTests
//
//  Created by Changappa K S on 23/08/24.
//

import XCTest
import UIKit
@testable import MovieDataBase

class MovieListViewControllerTests: XCTestCase {
    
    var sut: MovieListViewController!
    var mockNavigationController: MockNavigationController!
    var storyboard: UIStoryboard!

    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "MovieListViewController") as? MovieListViewController
        mockNavigationController = MockNavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockNavigationController = nil
        storyboard = nil
        super.tearDown()
    }

    // MARK: - Test numberOfRowsInSection
    func testNumberOfRowsInSection() {
        // Given
        sut.movies = [
            Movie(title: "Inception", year: "2010", rated: nil, released: nil, runtime: nil, genre: nil, director: nil, writer: nil, actors: nil, plot: nil, language: nil, country: nil, awards: nil, poster: nil, ratings: nil, metascore: nil, imdbRating: nil, imdbVotes: nil, imdbID: nil, type: nil, dvd: nil, boxOffice: nil, production: nil, website: nil, response: nil),
            Movie(title: "The Dark Knight", year: "2008", rated: nil, released: nil, runtime: nil, genre: nil, director: nil, writer: nil, actors: nil, plot: nil, language: nil, country: nil, awards: nil, poster: nil, ratings: nil, metascore: nil, imdbRating: nil, imdbVotes: nil, imdbID: nil, type: nil, dvd: nil, boxOffice: nil, production: nil, website: nil, response: nil)
        ]

        // When
        let numberOfRows = sut.tableView(sut.movieListTableView, numberOfRowsInSection: 0)

        // Then
        XCTAssertEqual(numberOfRows, 2)
    }

    // MARK: - Test cellForRowAt
    func testCellForRowAt_withValidData_shouldReturnConfiguredCell() {
        // Given
        sut.movies = [
            Movie(title: "Inception", year: "2010", rated: nil, released: nil, runtime: nil, genre: nil, director: nil, writer: nil, actors: nil, plot: nil, language: nil, country: nil, awards: nil, poster: nil, ratings: nil, metascore: nil, imdbRating: nil, imdbVotes: nil, imdbID: nil, type: nil, dvd: nil, boxOffice: nil, production: nil, website: nil, response: nil)
        ]

        // When
        let cell = sut.tableView(sut.movieListTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MoviesTVCell

        // Then
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.movieTitleLabel.text, "Inception")
    }

    // MARK: - Test didSelectRowAt
    func testDidSelectRowAt_shouldNavigateToMovieDetailsViewController() {
        // Given
        sut.movies = [
            Movie(title: "Inception", year: "2010", rated: nil, released: nil, runtime: nil, genre: nil, director: nil, writer: nil, actors: nil, plot: nil, language: nil, country: nil, awards: nil, poster: nil, ratings: nil, metascore: nil, imdbRating: nil, imdbVotes: nil, imdbID: nil, type: nil, dvd: nil, boxOffice: nil, production: nil, website: nil, response: nil)
        ]

        // When
        sut.tableView(sut.movieListTableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertTrue(mockNavigationController.pushedViewController is MovieDetailsViewController)
        let detailsVC = mockNavigationController.pushedViewController as? MovieDetailsViewController
        XCTAssertEqual(detailsVC?.movie?.title, "Inception")
    }
}

// MARK: - Mock Navigation Controller
class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
