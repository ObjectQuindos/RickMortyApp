//
//  RickAndMortyUITests+Utils.swift
//  RickAndMortyUITests
//
//  Created by David López on 29/10/23.
//

import XCTest

extension RickAndMortyUITests {
    
    func getFistRowInList(identifier: String) -> XCUIElement {
        let predicate = NSPredicate(format: "identifier == '\(identifier)'")
        let list = app.descendants(matching: .any).matching(predicate).firstMatch
        let row = list.cells.element(boundBy: 0)
        return row
    }
    
    func getRowBy(identifier: String) -> XCUIElement {
        let predicate = NSPredicate(format: "identifier == '\(identifier)'")
        let row = app.descendants(matching: .any).matching(predicate).firstMatch
        return row
    }
}
