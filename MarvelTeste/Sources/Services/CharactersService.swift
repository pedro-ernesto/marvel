//
//  CharactersService.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation

class CharactersService {
    private let publicKey = "a176c64904a4ccccf896c924ee3a15b1"
    private let privateKey = "b3ae6a9f7bc061e2724c5bfe70cfd1e2537627e7"
    private let hash = "d6536616c4ceb6a3447fcd9750f3c02b"
    
    func getCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        let timestamp = "12"

        var components = URLComponents(string: Urls.characters)
        components?.queryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]

        guard let url = components?.url else {
            completion(.failure(NSError(domain: "", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty response from api"])))
                return
            }
            guard let decodedData: CharacterApiResponse = ServicesUtils.decodeJson(from: data) else {
                    completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to decode response"])))
                    return
                }
            guard let characters: [Character] = decodedData.data.results else {
                completion(.failure(NSError(domain: "", code: 2, userInfo: [NSLocalizedDescriptionKey: "Empty character list"])))
                return
            }
            completion(.success(characters))
        }.resume()
    }
    
    func getMockedCharacters() -> [Character] {
        let image = Character.Image(path: "kaka", imageExtension: "seila filho")
        
        let miranha: Character = Character(id: 0, name: "miranha", description: "o brabo", thumbnail: image, isFavorite: false)
        let capitaoDasAmerica: Character = Character(id: 1, name: "capitao das america", description: "o brabo das america", thumbnail: image, isFavorite: false)
        
        let mockedCharacters = [miranha, capitaoDasAmerica]
        
        return mockedCharacters
    }
}
