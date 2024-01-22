//
//  HomeViewModel.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/20/24.
//

import Foundation

class HomeViewModel {
    weak public var delegate: HomeViewModelDelegate?
    private let charactersService: CharactersService
    private(set) var characters: [Character] = []
    private let favoriteCharactersUserDefaults = FavoriteCharactersUserDefaults()
    
    //todo- refactor into factory
    init(service: CharactersService = CharactersService()) {
        self.charactersService = service
    }
    
    func getCharacters() {
        charactersService.getCharacters() { [weak self] result in
            let characters = self?.handleGetCharactersResponse(result) ?? []
            DispatchQueue.main.async {
                self?.delegate?.handleUpdatedCharacters(characters)
                self?.characters = characters
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
        guard let favoritedCharacters = favoriteCharactersUserDefaults.getItems() else{
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
            if (favoritedCharacters[characterId] != nil) {
                newCharacter.isFavorite.toggle()
                toggledCharacters.append(newCharacter)
                return
            } else {
                toggledCharacters.append(newCharacter)
            }
        })
        return toggledCharacters
    }
    
    func searchCharacters(with name: String) -> [Character]? {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (trimmedName.isEmpty) {
            return self.characters
        } else {
            let filteredCharacters = self.characters.filter { $0.character.name?.trimmingCharacters(in: .whitespacesAndNewlines).contains(name) ?? false}
            
            return filteredCharacters
        }
    }
    
    func toggleFavorite(for selectedCharacter: Character) {
        guard let characterIndex = self.characters.firstIndex(where: { $0.character.id == selectedCharacter.character.id }) else {
            print("Could not find character")
            return
        }
        self.characters[characterIndex].isFavorite.toggle()
        self.delegate?.handleUpdatedCharacters(characters)
        saveFavoriteCharacterLocally(characters[characterIndex])
    }
    
    private func saveFavoriteCharacterLocally (_ character: Character) {
        guard let characterId = character.character.id else {
            return
        }
        favoriteCharactersUserDefaults.saveItem(with: characterId, for: character)
    }
}
