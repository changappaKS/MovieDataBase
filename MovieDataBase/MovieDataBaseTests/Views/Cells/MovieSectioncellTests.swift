//
//  MovieSectioncellTests.swift
//  MovieDataBaseTests
//
//  Created by Changappa K S on 23/08/24.
//

import XCTest
@testable import MovieDataBase

class MovieSectioncellTests: XCTestCase {
    
    var movieSectionTVCell: MovieSectionTVCell!
    
    override func setUp() {
        super.setUp()
        let nib = UINib(nibName: AppIdentifiers.CellIdentifiers.movieSectionTVCell, bundle: nil)
        movieSectionTVCell = nib.instantiate(withOwner: nil, options: nil).first as? MovieSectionTVCell
    }
    
    override func tearDown() {
        movieSectionTVCell = nil
        super.tearDown()
    }
    
    func testAwakeFromNib() {
        movieSectionTVCell.awakeFromNib()
        
        XCTAssertNotNil(movieSectionTVCell)
    }
    
    func testOutletsAreConnected() {
        XCTAssertNotNil(movieSectionTVCell.sectionTitle, "sectionTitle should be connected")
        XCTAssertNotNil(movieSectionTVCell.arrowLabel, "arrowLabel should be connected")
    }
    
    func testSetSelected() {
        movieSectionTVCell.setSelected(true, animated: false)
        XCTAssertTrue(movieSectionTVCell.isSelected, "The cell should be selected")
    }
}
