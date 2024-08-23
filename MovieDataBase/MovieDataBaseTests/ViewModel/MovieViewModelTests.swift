//
//  MovieViewModelTests.swift
//  MovieDataBaseTests
//
//  Created by Changappa K S on 23/08/24.
//

import XCTest
@testable import MovieDataBase

class MovieViewModelTests: XCTestCase {

    var viewModel: MovieViewModel!
    var mockMovies: [Movie]!

    override func setUpWithError() throws {
        super.setUp()
        viewModel = MovieViewModel()

        // Mock data for testing
        mockMovies = [
            Movie(title: "Inception", year: "2010", rated: "PG-13", released: "16 Jul 2010", runtime: "148 min", genre: "Action, Sci-Fi", director: "Christopher Nolan", writer: "Christopher Nolan", actors: "Leonardo DiCaprio, Joseph Gordon-Levitt", plot: "A thief who steals corporate secrets...", language: "English", country: "USA", awards: "Won 4 Oscars", poster: nil, ratings: nil, metascore: "74", imdbRating: "8.8", imdbVotes: "2,000,000", imdbID: nil, type: nil, dvd: nil, boxOffice: nil, production: nil, website: nil, response: nil),
            Movie(title: "The Dark Knight", year: "2008", rated: "PG-13", released: "18 Jul 2008", runtime: "152 min", genre: "Action, Crime, Drama", director: "Christopher Nolan", writer: "Jonathan Nolan, Christopher Nolan", actors: "Christian Bale, Heath Ledger", plot: "When the menace known as the Joker...", language: "English", country: "USA", awards: "Won 2 Oscars", poster: nil, ratings: nil, metascore: "84", imdbRating: "9.0", imdbVotes: "2,300,000", imdbID: nil, type: nil, dvd: nil, boxOffice: nil, production: nil, website: nil, response: nil)
        ]
        viewModel.processMovies(movies: mockMovies)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockMovies = nil
        super.tearDown()
    }

    /// Test if movies are loaded correctly and sections are created
    func testProcessMovies() throws {
        XCTAssertEqual(viewModel.items.count, 5, "There should be 5 sections: Year, Genre, Director, Actor, All Movies")

        let yearSection = viewModel.items[0]
        if case let MovieViewModelSection.year(years) = yearSection {
            XCTAssertEqual(years.count, 2, "There should be 2 unique years")
            XCTAssertTrue(years.contains("2010"))
            XCTAssertTrue(years.contains("2008"))
        } else {
            XCTFail("Year section not properly processed")
        }

        let genreSection = viewModel.items[1]
        if case let MovieViewModelSection.genre(genres) = genreSection {
            XCTAssertEqual(genres.count, 4, "There should be 4 genres")
            XCTAssertTrue(genres.contains("Action"))
            XCTAssertTrue(genres.contains("Sci-Fi"))
            XCTAssertTrue(genres.contains("Crime"))
            XCTAssertTrue(genres.contains("Drama"))
        } else {
            XCTFail("Genre section not properly processed")
        }

        let directorSection = viewModel.items[2]
        if case let MovieViewModelSection.director(directors) = directorSection {
            XCTAssertEqual(directors.count, 1, "There should be 1 director")
            XCTAssertTrue(directors.contains("Christopher Nolan"))
        } else {
            XCTFail("Director section not properly processed")
        }

        let actorSection = viewModel.items[3]
        if case let MovieViewModelSection.actor(actors) = actorSection {
            XCTAssertEqual(actors.count, 4, "There should be 4 actors")
            XCTAssertTrue(actors.contains("Leonardo DiCaprio"))
            XCTAssertTrue(actors.contains("Joseph Gordon-Levitt"))
            XCTAssertTrue(actors.contains("Christian Bale"))
            XCTAssertTrue(actors.contains("Heath Ledger"))
        } else {
            XCTFail("Actor section not properly processed")
        }
    }

    // Test fetching movies by year
    func testFetchMoviesByYear() throws {
        let movies2010 = viewModel.fetchMoviesByYear(year: "2010")
        XCTAssertEqual(movies2010.count, 1)
        XCTAssertEqual(movies2010.first?.title, "Inception")
    }

    // Test fetching movies by genre
    func testFetchMoviesByGenre() throws {
        let moviesSciFi = viewModel.fetchMoviesByGenre(genre: "Sci-Fi")
        XCTAssertEqual(moviesSciFi.count, 1)
        XCTAssertEqual(moviesSciFi.first?.title, "Inception")
    }

    // Test fetching movies by director
    func testFetchMoviesByDirector() throws {
        let moviesByNolan = viewModel.fetchMoviesByDirector(director: "Christopher Nolan")
        XCTAssertEqual(moviesByNolan.count, 2)
        XCTAssertTrue(moviesByNolan.contains(where: { $0.title == "Inception" }))
        XCTAssertTrue(moviesByNolan.contains(where: { $0.title == "The Dark Knight" }))
    }

    // Test fetching movies by actor
    func testFetchMoviesByActor() throws {
        let moviesByDiCaprio = viewModel.fetchMoviesByActor(actor: "Leonardo DiCaprio")
        XCTAssertEqual(moviesByDiCaprio.count, 1)
        XCTAssertEqual(moviesByDiCaprio.first?.title, "Inception")
    }

    // Test search functionality
    func testSearchMovies() throws {
        viewModel.searchMovies(with: "Inception")
        XCTAssertTrue(viewModel.isSearching)
        XCTAssertEqual(viewModel.filteredMovies.count, 1)
        XCTAssertEqual(viewModel.filteredMovies.first?.title, "Inception")
    }

    // Test canceling search
    func testCancelSearch() throws {
        viewModel.searchMovies(with: "Inception")
        viewModel.cancelSearch()
        XCTAssertFalse(viewModel.isSearching)
        XCTAssertEqual(viewModel.filteredMovies.count, 0)
    }

    // Test toggling collapse state
    func testToggleCollapseState() throws {
        let initialState = viewModel.isCollapsed(section: .year)
        viewModel.toggleCollapseState(for: .year)
        let toggledState = viewModel.isCollapsed(section: .year)
        XCTAssertNotEqual(initialState, toggledState)
    }
}
