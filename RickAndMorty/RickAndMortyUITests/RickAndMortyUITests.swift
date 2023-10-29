//
//  RickAndMortyUITests.swift
//  RickAndMortyUITests
//
//  Created by David López on 22/10/23.
//

import XCTest

final class RickAndMortyUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    func testFirstRowFlow() throws {
        app.launch()
        
        let firstRow = getFistRowInList(identifier: "listCharacters")
        firstRow.tap()
        
        let nameRow = getRowBy(identifier: "nameRow")
        XCTAssertTrue(nameRow.exists, "List with row should exist")
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
