//
//  MovieModelTests.swift
//  MovieDataBaseTests
//
//  Created by Changappa K S on 23/08/24.
//

import XCTest
@testable import MovieDataBase

class MovieModelTests: XCTestCase {
    
    func testDecodingMovieFromExampleJSON() {
        let json = """
        {
            "Title": "Punch-Drunk Love",
            "Year": "2002",
            "Rated": "R",
            "Released": "01 Nov 2002",
            "Runtime": "95 min",
            "Genre": "Comedy, Drama, Romance, Thriller",
            "Director": "Paul Thomas Anderson",
            "Writer": "Paul Thomas Anderson",
            "Actors": "Adam Sandler, Jason Andrews, Don McManus, Emily Watson",
            "Plot": "Barry Egan hates himself and hates his life...",
            "Language": "English",
            "Country": "USA",
            "Awards": "Nominated for 1 Golden Globe...",
            "Poster": "https://m.media-amazon.com/images/M/MV5BYmE1OTY4NjgtYjcwNC00NWE4LWJiNGMtZmVhYTdlMWE1YzIxXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
            "Ratings": [{
                "Source": "Internet Movie Database",
                "Value": "7.3/10"
            }, {
                "Source": "Rotten Tomatoes",
                "Value": "79%"
            }, {
                "Source": "Metacritic",
                "Value": "78/100"
            }],
            "Metascore": "78",
            "imdbRating": "7.3",
            "imdbVotes": "147,281",
            "imdbID": "tt0272338",
            "Type": "movie",
            "DVD": "N/A",
            "BoxOffice": "$17,844,216",
            "Production": "Ghoulardi Film Company, Revolution Films",
            "Website": "N/A",
            "Response": "True"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let movie = try decoder.decode(Movie.self, from: json)
            
            XCTAssertEqual(movie.title, "Punch-Drunk Love")
            XCTAssertEqual(movie.year, "2002")
            XCTAssertEqual(movie.rated, "R")
            XCTAssertEqual(movie.released, "01 Nov 2002")
            XCTAssertEqual(movie.runtime, "95 min")
            XCTAssertEqual(movie.genre, "Comedy, Drama, Romance, Thriller")
            XCTAssertEqual(movie.director, "Paul Thomas Anderson")
            XCTAssertEqual(movie.writer, "Paul Thomas Anderson")
            XCTAssertEqual(movie.actors, "Adam Sandler, Jason Andrews, Don McManus, Emily Watson")
            XCTAssertEqual(movie.plot, "Barry Egan hates himself and hates his life...")
            XCTAssertEqual(movie.language, "English")
            XCTAssertEqual(movie.country, "USA")
            XCTAssertEqual(movie.awards, "Nominated for 1 Golden Globe...")
            XCTAssertEqual(movie.poster, "https://m.media-amazon.com/images/M/MV5BYmE1OTY4NjgtYjcwNC00NWE4LWJiNGMtZmVhYTdlMWE1YzIxXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg")
            
            XCTAssertEqual(movie.ratings?.count, 3)
            XCTAssertEqual(movie.ratings?[0].source, "Internet Movie Database")
            XCTAssertEqual(movie.ratings?[0].value, "7.3/10")
            XCTAssertEqual(movie.ratings?[1].source, "Rotten Tomatoes")
            XCTAssertEqual(movie.ratings?[1].value, "79%")
            XCTAssertEqual(movie.ratings?[2].source, "Metacritic")
            XCTAssertEqual(movie.ratings?[2].value, "78/100")
            
            XCTAssertEqual(movie.metascore, "78")
            XCTAssertEqual(movie.imdbRating, "7.3")
            XCTAssertEqual(movie.imdbVotes, "147,281")
            XCTAssertEqual(movie.imdbID, "tt0272338")
            XCTAssertEqual(movie.type, "movie")
            XCTAssertEqual(movie.dvd, "N/A")
            XCTAssertEqual(movie.boxOffice, "$17,844,216")
            XCTAssertEqual(movie.production, "Ghoulardi Film Company, Revolution Films")
            XCTAssertEqual(movie.website, "N/A")
            XCTAssertEqual(movie.response, "True")
            
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}

class RatingModelTests: XCTestCase {
    
    func testDecodingRatingFromJSON() {
        let json = """
        {
            "Source": "Internet Movie Database",
            "Value": "7.3/10"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let rating = try decoder.decode(Rating.self, from: json)
            
            XCTAssertEqual(rating.source, "Internet Movie Database")
            XCTAssertEqual(rating.value, "7.3/10")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}
