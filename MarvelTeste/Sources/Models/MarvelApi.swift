//
//  Character.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation

struct CharacterApiResponse: Decodable {
    let code: Int?
    let status: String?
    let data: Data
    
    struct Data: Decodable {
        let offset: Int?
        let limit: Int?
        let total: Int?
        let count: Int?
        let results: [Character]?
    }
    
    struct Character: Decodable {
        let id: Int?
        let name: String?
        let description: String?
        let thumbnail: Image?
        
        struct Image: Decodable {
            let path: String?
            let imageExtension: String?
        }
    }
}
