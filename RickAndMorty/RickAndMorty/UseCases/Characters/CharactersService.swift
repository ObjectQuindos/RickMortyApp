//
//  CharactersService.swift
//  RickAndMorty
//
//  Created by David López on 22/10/23.
//

import Foundation

final class CharactersService {
    
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func getAllCharacters(pageNumber: Int) async throws -> CharacterAllData {
        let task = CharactersTask.listAllCharacters(pageNumber)
        let response = try await self.client.requestCodableAsyncAwait(task)
        
        do {
            return try decode(CharacterAllData.self, response: response)
            
        } catch let error { throw error }
    }
    
    func getLocation(id: String) async throws -> LocationInfo {
        
        let task = CharactersTask.location(id)
        let response = try await self.client.requestCodableAsyncAwait(task)
        
        do {
            return try decode(LocationInfo.self, response: response)
            
        } catch let error { throw error }
    }
    
    func getOrigin(id: String) async throws -> OriginInfo {
        
        let task = CharactersTask.origin(id)
        let response = try await self.client.requestCodableAsyncAwait(task)
        
        do {
            return try decode(OriginInfo.self, response: response)
            
        } catch let error { throw error }
    }
    
    private func decode<T>(_ data: T.Type, response: Response) throws -> T where T: Codable  {
        
        let decoder = JSONDecoder()
        
        do {
            let responseDecoded = try decoder.decode(T.self, from: response.data ?? Data())
            return responseDecoded
            
        } catch let error {
            throw error
        }
    }
}
