//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by David López on 22/10/23.
//

import XCTest
@testable import RickAndMorty

final class RickAndMortyTests: XCTestCase {
    
    func testFetchCharacters() async {
        let expectedCode = 200
        
        let client = APIClient(httpClient: Edge(with: Constants.baseURL))
        let task = CharactersTask.listAllCharacters(1)
        
        do {
            let response = try await client.requestCodableAsyncAwait(task)
            XCTAssertEqual(expectedCode, response.status, "Request Failed")
            
        } catch let error {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }
    
    func testLocation() async {
        let expectedCode = 200
        let idLocation = "1"
        
        let client = APIClient(httpClient: Edge(with: Constants.baseURL))
        let task = CharactersTask.location(idLocation)
        
        do {
            let response = try await client.requestCodableAsyncAwait(task)
            XCTAssertEqual(expectedCode, response.status, "Request Failed")
            
        } catch let error {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }
}
