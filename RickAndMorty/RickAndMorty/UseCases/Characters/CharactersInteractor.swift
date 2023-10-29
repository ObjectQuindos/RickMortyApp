//
//  CharactersInteractor.swift
//  RickAndMorty
//
//  Created by David López on 22/10/23.
//

import Foundation

final class CharactersInteractor {
    
    private let service: CharactersService
    
    init(service: CharactersService = Assembly.characterService) {
        self.service = service
    }
    
    func getAllCharacters(pageNumber: Int) async throws -> CharacterAllData {
        try await service.getAllCharacters(pageNumber: pageNumber)
    }
    
    func getLocation(id: String) async throws -> LocationInfo {
        try await service.getLocation(id: id)
    }
    
    func getOrigin(id: String) async throws -> OriginInfo {
        try await service.getOrigin(id: id)
    }
}
