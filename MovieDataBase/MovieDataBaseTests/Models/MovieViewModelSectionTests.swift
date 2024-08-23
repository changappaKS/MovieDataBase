//
//  MovieViewModelSectionTests.swift
//  MovieDataBaseTests
//
//  Created by Changappa K S on 23/08/24.
//

import XCTest
@testable import MovieDataBase

class MovieViewModelSectionTests: XCTestCase {
    
    func testSectionType() {
        let yearSection = MovieViewModelSection.year(items: ["2021", "2022"])
        XCTAssertEqual(yearSection.type, .year)

        let genreSection = MovieViewModelSection.genre(items: ["Action", "Comedy"])
        XCTAssertEqual(genreSection.type, .genre)

        let directorSection = MovieViewModelSection.director(items: ["Nolan", "Tarantino"])
        XCTAssertEqual(directorSection.type, .director)

        let actorSection = MovieViewModelSection.actor(items: ["DiCaprio", "Pitt"])
        XCTAssertEqual(actorSection.type, .actor)

        let allMoviesSection = MovieViewModelSection.allMovies(items: [createMockMovie(title: "Inception"), createMockMovie(title: "Interstellar")])
        XCTAssertEqual(allMoviesSection.type, .allMovies)
    }
    
    func testSectionTitle() {
        let yearSection = MovieViewModelSection.year(items: ["2021", "2022"])
        XCTAssertEqual(yearSection.sectionTitle, AppStrings.SectionTitles.year)

        let genreSection = MovieViewModelSection.genre(items: ["Action", "Comedy"])
        XCTAssertEqual(genreSection.sectionTitle, AppStrings.SectionTitles.genre)

        let directorSection = MovieViewModelSection.director(items: ["Nolan", "Tarantino"])
        XCTAssertEqual(directorSection.sectionTitle, AppStrings.SectionTitles.directors)

        let actorSection = MovieViewModelSection.actor(items: ["DiCaprio", "Pitt"])
        XCTAssertEqual(actorSection.sectionTitle, AppStrings.SectionTitles.actors)

        let allMoviesSection = MovieViewModelSection.allMovies(items: [createMockMovie(title: "Inception"), createMockMovie(title: "Interstellar")])
        XCTAssertEqual(allMoviesSection.sectionTitle, AppStrings.SectionTitles.allMovies)
    }
    
    func testRowCount() {
        let yearSection = MovieViewModelSection.year(items: ["2021", "2022"])
        XCTAssertEqual(yearSection.rowCount, 2)

        let genreSection = MovieViewModelSection.genre(items: ["Action", "Comedy", "Drama"])
        XCTAssertEqual(genreSection.rowCount, 3)

        let directorSection = MovieViewModelSection.director(items: ["Nolan"])
        XCTAssertEqual(directorSection.rowCount, 1)

        let actorSection = MovieViewModelSection.actor(items: ["DiCaprio", "Pitt", "Hardy"])
        XCTAssertEqual(actorSection.rowCount, 3)

        let allMoviesSection = MovieViewModelSection.allMovies(items: [createMockMovie(title: "Inception"), createMockMovie(title: "Interstellar"), createMockMovie(title: "Dunkirk")])
        XCTAssertEqual(allMoviesSection.rowCount, 3)
    }
    
    func testItemAt() {
        let yearSection = MovieViewModelSection.year(items: ["2021", "2022"])
        XCTAssertEqual(yearSection.item(at: 0) as? String, "2021")
        XCTAssertEqual(yearSection.item(at: 1) as? String, "2022")

        let genreSection = MovieViewModelSection.genre(items: ["Action", "Comedy"])
        XCTAssertEqual(genreSection.item(at: 0) as? String, "Action")
        XCTAssertEqual(genreSection.item(at: 1) as? String, "Comedy")

        let directorSection = MovieViewModelSection.director(items: ["Nolan", "Tarantino"])
        XCTAssertEqual(directorSection.item(at: 0) as? String, "Nolan")
        XCTAssertEqual(directorSection.item(at: 1) as? String, "Tarantino")

        let actorSection = MovieViewModelSection.actor(items: ["DiCaprio", "Pitt"])
        XCTAssertEqual(actorSection.item(at: 0) as? String, "DiCaprio")
        XCTAssertEqual(actorSection.item(at: 1) as? String, "Pitt")

        let movie1 = createMockMovie(title: "Inception")
        let movie2 = createMockMovie(title: "Interstellar")
        let allMoviesSection = MovieViewModelSection.allMovies(items: [movie1, movie2])
        XCTAssertEqual((allMoviesSection.item(at: 0) as? Movie)?.title, "Inception")
        XCTAssertEqual((allMoviesSection.item(at: 1) as? Movie)?.title, "Interstellar")
    }

    // Helper function to create a mock Movie object
    private func createMockMovie(title: String) -> Movie {
        return Movie(
            title: title,
            year: nil,
            rated: nil,
            released: nil,
            runtime: nil,
            genre: nil,
            director: nil,
            writer: nil,
            actors: nil,
            plot: nil,
            language: nil,
            country: nil,
            awards: nil,
            poster: nil,
            ratings: nil,
            metascore: nil,
            imdbRating: nil,
            imdbVotes: nil,
            imdbID: nil,
            type: nil,
            dvd: nil,
            boxOffice: nil,
            production: nil,
            website: nil,
            response: nil
        )
    }
}
