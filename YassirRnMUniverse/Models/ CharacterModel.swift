//
//   CharacterModel.swift
//  YassirRnMUniverse
//
//  Created by Rotimi Joshua on 25/08/2024.
//

import Foundation

struct Character: Codable, Identifiable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var image: String
    var gender: String
}

struct CharacterResponse: Codable {
    let results: [Character]
}
