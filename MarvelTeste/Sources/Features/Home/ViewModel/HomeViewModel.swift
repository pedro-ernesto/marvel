//
//  HomeViewModel.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/20/24.
//

import Foundation
import UIKit

class HomeViewModel {
    weak public var delegate: HomeViewModelDelegate?
    private let charactersService: CharactersService
    private(set) var currentCharacters: [Character] = []
    private(set) var characters: [Character] = []
    private let favoriteCharacterManager = FavoriteCharacterManager()
    
    //todo- refactor into factory
    init() {
        let service = CharactersService()
        self.charactersService = service
    }
    
    func getCharacters() {
        charactersService.getCharacters() { [weak self] result in
            let characters = self?.handleGetCharactersResponse(result) ?? []
            DispatchQueue.main.async {
                self?.favoriteCharacterManager.saveAllCharacters(characters)
                self?.characters = characters
                self?.currentCharacters = characters
                self?.getImages()
                self?.delegate?.handleUpdatedCharacters()
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Error: Invalid HTTP response code")
                    completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response code"]))
                    return
                }

                guard let data = data, let image = UIImage(data: data) else {
                    print("Error: No image data or corrupted data")
                    completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No image data or corrupted data"]))
                    return
                }

                completion(image, nil)
            }
        }.resume()
    }
    
    func downloadThumbnails(for characters: [Character], completion: @escaping ([Character]) -> Void) {
        var updatedCharacters = characters
        let dispatchGroup = DispatchGroup()

        for (index, character) in characters.enumerated() {
            if let thumbnailUrl = character.url {
                dispatchGroup.enter()
                downloadImage(from: thumbnailUrl) { image, error in
                    if let error {
                        print(error)
                        updatedCharacters[index].image = UIImage(named: "defaultImage")
                    } else {
                        updatedCharacters[index].image = image
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(updatedCharacters)
        }
    }
    
    func getImages() {
        downloadThumbnails(for: self.characters) { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.handleUpdatedCharacters()
                self?.characters = result
                self?.currentCharacters = result
            }
        }
    }
    
    private func handleGetCharactersResponse(_ result: Result<[CharacterApiResponse.Character], Error>) -> [Character]? {
        switch result {
        case .success(let apiCharacters):
            let characters: [Character] = apiCharacters.map({character in return
                Character(character: character)
            })
            
            let toggledCharacters = toggleFavoriteCharacters(characters)
            
            return toggledCharacters
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
    
    // toggle favorite if a character exists in local storage
    private func toggleFavoriteCharacters (_ characters: [Character]) -> [Character] {
        guard let favoriteIds = favoriteCharacterManager.getFavoriteIds() else {
            return characters
        }
        
        var toggledCharacters: [Character] = []
        
        characters.forEach({
            character in
            var newCharacter = character;
            guard let characterId = character.character.id else {
                toggledCharacters.append(newCharacter)
                return
            }
            if (favoriteIds.contains(characterId)) {
                newCharacter.isFavorite.toggle()
                toggledCharacters.append(newCharacter)
                return
            } else {
                toggledCharacters.append(newCharacter)
            }
        })
        return toggledCharacters
    }
    
    func searchCharacters(with name: String) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (trimmedName.isEmpty) {
            self.currentCharacters = self.characters
            self.delegate?.handleUpdatedCharacters()
        } else {
            let filteredCharacters = self.characters.filter { $0.character.name?.trimmingCharacters(in: .whitespacesAndNewlines).contains(name) ?? false}
            
            self.currentCharacters = filteredCharacters
            self.delegate?.handleUpdatedCharacters()
        }
    }
    
    func toggleFavorite(for character: Character) {
        guard let index = self.characters.firstIndex(where: { $0.character.id == character.character.id }) else {
            print("Could not find character")
            return
        }
        
        let toggledCharacter = favoriteCharacterManager.toggleFavorite(for: character)
        
        self.currentCharacters[index] = toggledCharacter
        self.delegate?.handleUpdatedCharacters()
    }
}

