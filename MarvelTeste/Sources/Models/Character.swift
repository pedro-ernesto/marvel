//
//  Character.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation

struct Character: Decodable {
    var character: CharacterApiResponse.Character
    var isFavorite: Bool = false
}
