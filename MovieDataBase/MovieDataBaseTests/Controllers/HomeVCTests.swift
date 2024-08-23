//
//  HomeVCTests.swift
//  MovieDataBaseTests
//
//  Created by Changappa K S on 23/08/24.
//

import XCTest
import UIKit
@testable import MovieDataBase

class HomeViewControllerTests: XCTestCase {

    var viewController: HomeViewController!
    var tableView: UITableView!

    override func setUp() {
        super.setUp()
        // Initialize the storyboard and view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        viewController.loadViewIfNeeded()

        // Access the table view
        tableView = viewController.homeTableView
    }

    override func tearDown() {
        viewController = nil
        tableView = nil
        super.tearDown()
    }

    // Test the number of sections
    func testNumberOfSections() {
        let expectedSections = viewController.viewModel.items.count
        let numberOfSections = viewController.numberOfSections(in: tableView)
        XCTAssertEqual(numberOfSections, expectedSections, "Number of sections should match the view model items count.")
    }


    // Test cell for row at index path
    func testCellForRowAt() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewController.tableView(tableView, cellForRowAt: indexPath)

        XCTAssertNotNil(cell, "Cell should not be nil")
        XCTAssertTrue(cell is MoviesTVCell || cell is MovieSectionTVCell, "Cell should be of correct type")
    }

    // Test search bar text did change
    func testSearchBarTextDidChange() {
        let searchBar = viewController.searchBar!
        searchBar.text = "Inception"

        viewController.searchBar(searchBar, textDidChange: "Inception")

        XCTAssertTrue(viewController.viewModel.isSearching, "ViewModel should be in searching state")
    }

    // Test search bar cancel button clicked
    func testSearchBarCancelButtonClicked() {
        let searchBar = viewController.searchBar!
        searchBar.text = "Inception"

        viewController.searchBar(searchBar, textDidChange: "Inception")
        viewController.searchBarCancelButtonClicked(searchBar)

        XCTAssertFalse(viewController.viewModel.isSearching, "ViewModel should not be in searching state after cancel")
        XCTAssertEqual(viewController.viewModel.filteredMovies.count, 0, "Filtered movies count should be zero after cancel")
    }
}
