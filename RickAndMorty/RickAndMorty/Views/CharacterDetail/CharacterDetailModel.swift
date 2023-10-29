//
//  CharacterDetailModel.swift
//  RickAndMorty
//
//  Created by David López on 26/10/23.
//

import Foundation

class LocationModel {
    let id: Int
    let name: String
    let dimension: String?
    let type: String?
    
    init(from location: LocationInfo) {
        self.id = location.id
        self.name = location.name
        self.dimension = location.dimension
        self.type = location.type
    }
}

class OriginModel {
    let id: Int
    let name: String
    let dimension: String?
    let type: String?
    
    init(from origin: OriginInfo) {
        self.id = origin.id
        self.name = origin.name
        self.dimension = origin.dimension
        self.type = origin.type
    }
}

class CharacterDetailModel {
    let character: CharacterModel
    var location: LocationModel? = nil
    var origin: OriginModel? = nil
    
    init(with character: CharacterModel, location: LocationModel? = nil, origin: OriginModel? = nil) {
        self.character = character
    }
}
