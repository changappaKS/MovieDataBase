//
//  MovieDetailsVCTests.swift
//  MovieDataBaseTests
//
//  Created by Changappa K S on 23/08/24.
//

import XCTest
import UIKit
@testable import MovieDataBase

class MovieDetailsViewControllerTests: XCTestCase {
    
    var sut: MovieDetailsViewController!
    var movie: Movie!
    var imageLoader: ImageLoader!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController
        sut.loadViewIfNeeded()

        // Setting up a mock session for image loader
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        imageLoader = ImageLoader(session: session)

        movie = Movie(
            title: "Inception",
            year: "2010",
            rated: "PG-13",
            released: "16 Jul 2010",
            runtime: "148 min",
            genre: "Action, Adventure, Sci-Fi",
            director: "Christopher Nolan",
            writer: "Christopher Nolan",
            actors: "Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page",
            plot: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
            language: "English, Japanese, French",
            country: "USA, UK",
            awards: "Won 4 Oscars. Another 152 wins & 204 nominations.",
            poster: "https://example.com/inception.jpg",
            ratings: [Rating(source: "Internet Movie Database", value: "8.8/10")],
            metascore: "74",
            imdbRating: "8.8",
            imdbVotes: "2,000,000",
            imdbID: "tt1375666",
            type: "movie",
            dvd: "07 Dec 2010",
            boxOffice: "$292,576,195",
            production: "Syncopy, Warner Bros.",
            website: "N/A",
            response: "True"
        )

        sut.movie = movie
    }
    
    override func tearDown() {
        sut = nil
        movie = nil
        imageLoader = nil
        MockURLProtocol.requestHandler = nil
        URLCache.shared.removeAllCachedResponses()
        super.tearDown()
    }

    // MARK: - UI Setup Tests (excluding image loading)

    func testSetupView_setsMovieDetailsCorrectly() {
        // Test the setupView() method
        sut.setupView()

        XCTAssertEqual(sut.title, AppStrings.TitleStrings.movieDetails)
        XCTAssertEqual(sut.movieTitleLabel.text, movie.title)
        XCTAssertEqual(sut.plotTextView.text, "\(AppStrings.LabelTitles.plot) \n\n \(movie.plot ?? "")")
        XCTAssertEqual(sut.castCrewLabel.text, "\(AppStrings.LabelTitles.starring) \(movie.actors ?? "")")
        XCTAssertEqual(sut.directorLabel.text, "\(AppStrings.LabelTitles.director) \(movie.director ?? "")")
        XCTAssertEqual(sut.languageLabel.text, "\(AppStrings.LabelTitles.language) \(movie.language ?? "")")
        XCTAssertEqual(sut.writerLabel.text, "\(AppStrings.LabelTitles.writer) \(movie.writer ?? "")")
        XCTAssertEqual(sut.genreLabel.text, "\(AppStrings.LabelTitles.genre) \(movie.genre ?? "")")
        XCTAssertEqual(sut.yearsLabel.text, "\(AppStrings.LabelTitles.releaseDate) \(movie.year ?? "")")
    }

    func testUpdateTextViewHeight_adjustsHeightCorrectly() {
        // Set some text in the plotTextView and call updateTextViewHeight()
        sut.plotTextView.text = movie.plot
        
        // Ensure that the text view is not scrollable and fits its content
        XCTAssertFalse(sut.plotTextView.isScrollEnabled)
        XCTAssertTrue(sut.plotTextView.contentSize.height <= sut.plotTextView.frame.size.height)
    }

    // MARK: - Image Loading Tests with Mocked Network Responses

    func testSetupView_loadsImageSuccessfully() {
        // Mock a successful image load
        let imageData = UIImage(systemName: "star.fill")?.pngData()
        let url = URL(string: "https://example.com/inception.jpg")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        mockURLSession(with: imageData, response: response, error: nil)

        sut.setupView()

        let expectation = self.expectation(description: "Image load expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertNotNil(sut.moviePosterImageView.image)
    }

    func testSetupView_withInvalidURL_setsPlaceholderImage() {
        // Mock an invalid URL (error case)
        let error = NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        mockURLSession(with: nil, response: nil, error: error)

        sut.setupView()

        let expectation = self.expectation(description: "Image load expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertEqual(sut.moviePosterImageView.image, UIImage(named: "folderThumbnail"))
    }

    func testSetupView_withNetworkError_setsPlaceholderImage() {
        // Mock a network error
        let url = URL(string: "https://example.com/inception.jpg")!
        let error = NSError(domain: "NetworkError", code: -1, userInfo: nil)

        mockURLSession(with: nil, response: nil, error: error)

        sut.setupView()

        let expectation = self.expectation(description: "Image load expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertEqual(sut.moviePosterImageView.image, UIImage(named: "folderThumbnail"))
    }

    // MARK: - Helper Methods for Mocking URLSession

    private func mockURLSession(with data: Data?, response: URLResponse?, error: Error?) {
        MockURLProtocol.requestHandler = { request in
            let httpResponse = response as? HTTPURLResponse
            return (httpResponse, data, error)
        }
    }
}
