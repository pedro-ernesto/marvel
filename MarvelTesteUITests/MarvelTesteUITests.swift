//
//  MarvelTesteUITests.swift
//  MarvelTesteUITests
//
//  Created by Pedro Ernersto on 1/20/24.
//

import XCTest

final class MarvelTesteUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }
    
    func testElementsExist() throws {
        let app = XCUIApplication()
        
        XCTAssertTrue(app.otherElements["homeView"].exists)
        
        XCTAssertTrue(app.tables["charactersList"].exists)
        XCTAssertTrue(app.buttons["favoritesButton"].exists)
        XCTAssertTrue(app.textFields["searchInput"].exists)
        XCTAssertTrue(app.buttons["searchButton"].exists)
    }
    
    func testFavoritesButton() throws {
        let app = XCUIApplication()
        
        // currently in home screen
        XCTAssertTrue(app.otherElements["homeView"].exists)
        
        let favoritesButton = app.buttons["favoritesButton"]

        favoritesButton.tap()
        
        XCTAssertTrue(app.otherElements["favoriteCharactersView"].exists)
    }
}
