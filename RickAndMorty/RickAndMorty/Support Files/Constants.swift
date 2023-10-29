//
//  Constants.swift
//  RickAndMorty
//
//  Created by David López on 25/10/23.
//

import Foundation

struct Constants {
    static let baseURL = "https://rickandmortyapi.com/api/"
    static let cacheName = "CacheRickMorty"
    static let thumbnailSize = CGSize(width: 64, height: 64)
    static let thumbnailDetailSize = CGSize(width: 150, height: 150)
    static let unkwown = "unkwown"
}

struct UIStrings {
    static let characterListNavigationTitle = "Personajes"
    static let emptySearchResults = "Sin resultados"
    static let characterDetailNavigationTitle = "Detalle del personaje"
    
    static let infoSectionTitle = "Información"
    static let locationSectionTitle = "Localización"
    static let originSectionTitle = "Origen"
    
    static let infoFirstRow = "Nombre"
    static let infoSecondRow = "Género"
    static let infoThirdRow = "Especie"
    static let infoFourthRow = "Estado"
    
    static let locationFirstRow = "Nombre"
    static let locationSecondRow = "Dimensión"
    static let locationThirdRow = "Tipo"
    
    static let listCharactersIdentifier = "listCharacters"
    static let listRowCharacterDetailIdentifier = "nameRow"
}
