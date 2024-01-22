//
//  Character.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation

struct Character: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Image?
    var isFavorite: Bool = false
    
    struct Image: Decodable {
        let path: String?
        let imageExtension: String?
    }
}
