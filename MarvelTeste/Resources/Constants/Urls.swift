//
//  Services.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation

struct Urls {
    private static let baseUrl = "https://gateway.marvel.com"
    
    private struct Routes {
        static let characters = "/v1/public/characters"
    }
    
    static var characters: String {
        return baseUrl  + Routes.characters
    }
}
