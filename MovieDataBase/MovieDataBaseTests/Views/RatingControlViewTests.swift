//
//  RatingControlViewTests.swift
//  MovieDataBaseTests
//
//  Created by Changappa K S on 23/08/24.
//

import XCTest
@testable import MovieDataBase

class RatingControlViewTests: XCTestCase {

    var ratingControlView: RatingControlView!

    override func setUp() {
        super.setUp()
        ratingControlView = RatingControlView(frame: CGRect(x: 0, y: 0, width: 320, height: 100))
    }

    override func tearDown() {
        ratingControlView = nil
        super.tearDown()
    }

    func testInitialSetup() {
        XCTAssertNotNil(ratingControlView.headerLabel)
        XCTAssertNotNil(ratingControlView.segmentedControl)
        XCTAssertNotNil(ratingControlView.ratingLabel)
        XCTAssertNotNil(ratingControlView.infoButton)

        XCTAssertEqual(ratingControlView.headerLabel.text, AppStrings.LabelTitles.rating)
        XCTAssertEqual(ratingControlView.segmentedControl.numberOfSegments, 0)
        XCTAssertEqual(ratingControlView.ratingLabel.text, "")
    }

    func testConfigureWithRatings() {
        let rating1 = Rating(source: "IMDB", value: "8.5")
        let rating2 = Rating(source: "MC", value: "2.5")
        let ratings = [rating1, rating2]

        ratingControlView.configure(with: ratings)

        XCTAssertEqual(ratingControlView.segmentedControl.numberOfSegments, 2)
        XCTAssertEqual(ratingControlView.segmentedControl.titleForSegment(at: 0), "IMDB")
        XCTAssertEqual(ratingControlView.segmentedControl.titleForSegment(at: 1), "MC")
        XCTAssertEqual(ratingControlView.ratingLabel.text, "8.5")
    }

    func testRatingSourceChanged() {
        let rating1 = Rating(source: "IMDB", value: "8.5")
        let rating2 = Rating(source: "MC", value: "2.5")
        let ratings = [rating1, rating2]

        ratingControlView.configure(with: ratings)
        ratingControlView.segmentedControl.selectedSegmentIndex = 1
        ratingControlView.ratingSourceChanged(ratingControlView.segmentedControl)

        XCTAssertEqual(ratingControlView.ratingLabel.text, "2.5")
    }

    func testShowAndHidePopover() {
        XCTAssertNil(ratingControlView.popoverView)
        
        ratingControlView.showRatingSourceInfo()
        XCTAssertNotNil(ratingControlView.popoverView)
        
        ratingControlView.showRatingSourceInfo()
        XCTAssertNil(ratingControlView.popoverView)
    }
}
