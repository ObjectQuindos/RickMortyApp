//
//  CharactersModel.swift
//  RickAndMorty
//
//  Created by David López on 23/10/23.
//

import Foundation

struct CharacterModel: Hashable, Identifiable {
    
    let id: Int
    let name: String
    let gender: String
    let imageURL: String
    let specie: String
    let status: String
    var location: Location?
    var origin: Origin?
    
    init(id: Int, name: String, gender: String, imageURL: String, specie: String, status: String, location: Location?, origin: Origin?) {
        self.id = id
        self.name = name
        self.gender = gender
        self.imageURL = imageURL
        self.specie = specie
        self.status = status
        self.location = location
        self.origin = origin
    }
    
    init(from character: Character) {
        self.id = character.id
        self.name = character.name
        self.gender = character.gender
        self.imageURL = character.imageURL
        self.specie = character.species
        self.status = character.status
        self.location = character.location
        self.origin = character.origin
    }
    
    static var emptyCharacter: CharacterModel {
        return CharacterModel(id: 0, name: UIStrings.emptySearchResults, gender: "", imageURL: "", specie: "", status: "", location: nil, origin: nil)
    }
}
