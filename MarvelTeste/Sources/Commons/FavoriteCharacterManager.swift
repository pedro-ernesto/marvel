//
//  FavoriteCharacterManager.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/23/24.
//

import Foundation

class FavoriteCharacterManager {
    private let favoriteCharactersUserDefaults = FavoriteCharactersUserDefaults()
    
    func getFavoriteCharacters() -> [Character]? {
        guard let characters = favoriteCharactersUserDefaults.getAllCharacters(),
              let favoriteIds = favoriteCharactersUserDefaults.getFavoriteId()
        else {
            return nil
        }
        
        let favoriteCharacters: [Character] = characters.compactMap({
            character in
            guard let characterId = character.character.id else {
                return nil
            }
            if (favoriteIds.contains(characterId)) {
                return character
            }
            return nil
        })
        
        return favoriteCharacters
    }
    
    func saveAllCharacters (_ characters: [Character]) {
        favoriteCharactersUserDefaults.saveAllCharacters(characters)
    }
    
    func getFavoriteIds() -> [Int]? {
        return favoriteCharactersUserDefaults.getFavoriteId()
    }
    
    
    func toggleFavorite(for character: Character) -> Character{
        var character = character
        guard let id = character.character.id else {
            return character
        }
        guard let ids = favoriteCharactersUserDefaults.getFavoriteId() else {
            character.isFavorite.toggle()
            
            return character
        }
        if (!ids.contains(id)) {
            favoriteCharactersUserDefaults.saveFavoriteId(with: id)
        } else {
            favoriteCharactersUserDefaults.removeFavoriteId(with: id)
        }
        character.isFavorite.toggle()
        
        return character
    }
}
