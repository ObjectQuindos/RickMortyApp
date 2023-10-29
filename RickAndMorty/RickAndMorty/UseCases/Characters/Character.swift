//
//  Character.swift
//  RickAndMorty
//
//  Created by David López on 23/10/23.
//

import Foundation

struct CharacterAllData: Codable {
    let results: [Character]
    let info: CharacterInfo
    
    enum CodingKeys: String, CodingKey {
        case results
        case info
    }
}

struct Character: Codable {
    let id: Int
    let name: String
    let gender: String
    let imageURL: String
    let type: String
    let species: String
    let status: String
    let episode: [String]
    let location: Location
    let origin: Origin
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case imageURL = "image"
        case type
        case species
        case status
        case episode
        case location
        case origin
        case created
    }
}

struct Location: Hashable, Codable {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct Origin: Hashable, Codable {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct CharacterInfo: Codable {
    
    let count, pages: Int
    let next, prev: String?
    
    enum CodingKeys: String, CodingKey {
        case count
        case pages
        case next
        case prev
    }
}

struct LocationInfo: Codable {
    let id: Int
    let name: String
    let dimension: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dimension
        case type
    }
}

struct OriginInfo: Codable {
    let id: Int
    let name: String
    let dimension: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dimension
        case type
    }
}
