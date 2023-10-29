//
//  CharactersTask.swift
//  RickAndMorty
//
//  Created by David López on 22/10/23.
//

import Foundation

enum CharactersTask {
    case listAllCharacters(Int)
    case location(String)
    case origin(String)
}

extension CharactersTask: Task {
    
    var path: String {
        switch self {
        case .listAllCharacters:
            return "character"
        case .location(let id), .origin(let id):
            return "location/" + id
        }
    }
    
    var method: String {
        switch self {
        case .listAllCharacters, .location, .origin:
            return "GET"
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var queryItems: [URLQueryItem]? {
        
        switch self {
            
        case .listAllCharacters(let pageNumber):
            return [ URLQueryItem(name: "page", value: String(pageNumber))]
            
        case .location, .origin: return nil
        }
    }
}
