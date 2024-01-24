//
//  Character.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation
import UIKit

struct CharacterApiResponse: Codable {
    let code: Int?
    let status: String?
    let data: Data
    
    struct Data: Codable {
        let offset: Int?
        let limit: Int?
        let total: Int?
        let count: Int?
        let results: [Character]?
    }
    
    struct Character: Codable {
        let id: Int?
        let name: String?
        let description: String?
        let thumbnail: Image?
        
        struct Image: Codable {
            let path: String?
            let `extension`: String?
        }
    }
}

extension CharacterApiResponse.Character {
    static func mock(id: Int = 1, name: String = "aranha", description: String = "aranha") -> CharacterApiResponse.Character {
        return CharacterApiResponse.Character(
            id: id,
            name: name,
            description: description,
            thumbnail: Image(path: "teste", extension: "jpg")
        )
    }
}
