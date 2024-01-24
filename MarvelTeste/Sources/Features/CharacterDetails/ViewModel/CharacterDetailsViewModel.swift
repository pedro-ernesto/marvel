//
//  CharacterDetailsViewModel.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation

class CharacterDetailsViewModel {
    private let favoriteCharacterManager = FavoriteCharacterManager()
    
    func toggleFavorite(for character: Character) -> Character {
        favoriteCharacterManager.toggleFavorite(for: character)
    }
}
