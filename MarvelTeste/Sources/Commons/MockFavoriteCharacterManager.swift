//
//  MockFavoriteCharacterManager.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/24/24.
//

import Foundation

class MockFavoriteCharacterManager: FavoriteCharacterManager {
    var favoriteIds: Set<Int> = []

    func getFavoriteIds() -> Set<Int>? {
        return favoriteIds
    }

    override func toggleFavorite(for character: Character) -> Character {
        var toggledCharacter = character
        toggledCharacter.isFavorite.toggle()
        return toggledCharacter
    }
}
