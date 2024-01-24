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
