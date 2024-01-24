//
//  MockCharactersService.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/24/24.
//

import Foundation

class MockCharactersService: CharactersService {
    var mockResult: Result<[CharacterApiResponse.Character], Error>?

    override func getCharacters(completion: @escaping (Result<[CharacterApiResponse.Character], Error>) -> Void) {
        completion(mockResult ?? .failure(NSError()))
    }
}
