//
//  YassirRnMUniverseUITests.swift
//  YassirRnMUniverseUITests
//
//  Created by Rotimi Joshua on 25/08/2024.
//

import XCTest

final class YassirRnMUniverseUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testCharacterListAndDetailsNavigation() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify the Characters screen is shown
        XCTAssertTrue(app.navigationBars["Characters"].exists, "Characters screen not loaded")

        // Verify the segmented control is visible
        let filterControl = app.segmentedControls.element(boundBy: 0)
        XCTAssertTrue(filterControl.exists, "Filter control does not exist")

        // Test the filter control
        filterControl.buttons["Alive"].tap()
        XCTAssertTrue(filterControl.buttons["Alive"].isSelected, "Alive filter not selected")

        // Verify that the table view is visible
        let tableView = app.tables.element(boundBy: 0)
        XCTAssertTrue(tableView.exists, "Characters table view does not exist")

        // Verify that the Character Details screen is shown
        let characterNameLabel = app.staticTexts["Rick Sanchez"]
        XCTAssertTrue(characterNameLabel.exists, "Character Details screen not shown")

        // Verify that we are back on the Characters list screen
        XCTAssertTrue(app.navigationBars["Characters"].exists, "Did not navigate back to the Characters screen")
    }
    func testLaunchPerformance() throws {
        if #available(iOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                let app = XCUIApplication()
                app.launchArguments = ["-UITestPerformance"]
                app.launch()
            }
        }
    }

}
