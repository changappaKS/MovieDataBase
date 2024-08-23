//
//  CategoryViewTests.swift
//  MovieDataBaseTests
//
//  Created by Changappa K S on 23/08/24.
//

import XCTest
@testable import MovieDataBase

final class CategoryViewTests: XCTestCase {
    
    var categoryView: CategoryView!
    
    override func setUp() {
        super.setUp()
        let nib = UINib(nibName: AppIdentifiers.NibName.categoryView, bundle: nil)
        categoryView = nib.instantiate(withOwner: nil, options: nil).first as? CategoryView
    }

    override func tearDown() {
        categoryView = nil
        super.tearDown()
    }

    func testConfigureCellForCollapsedState() {
        // Given
        let title = AppStrings.SectionTitles.year
        let isCollapsed = true
        
        // When
        categoryView.configureCell(title: title, isCollapsed: isCollapsed)
        
        // Then
        XCTAssertEqual(categoryView.titleLabel.text, title)
        XCTAssertEqual(categoryView.arrowImage.image, UIImage(systemName: "chevron.right"))
    }

    func testConfigureCellForExpandedState() {
        // Given
        let title = AppStrings.SectionTitles.genre
        let isCollapsed = false
        
        // When
        categoryView.configureCell(title: title, isCollapsed: isCollapsed)
        
        // Then
        XCTAssertEqual(categoryView.titleLabel.text, title)
        XCTAssertEqual(categoryView.arrowImage.image, UIImage(systemName: "chevron.down"))
    }
}
