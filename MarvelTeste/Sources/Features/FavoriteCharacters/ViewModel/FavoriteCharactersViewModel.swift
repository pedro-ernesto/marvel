//
//  FavoriteCharactersViewModel.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation

class FavoriteCharactersViewModel {
    private let favoriteCharacterManager = FavoriteCharacterManager()
    private(set) var characters: [Character] = []
    weak public var delegate: FavoriteCharactersViewModelDelegate?
    
    func getFavoriteCharacters(){
        guard let favoriteCharacters = favoriteCharacterManager.getFavoriteCharacters() else {
            delegate?.handleUpdatedCharacters()
            return
        }
        self.characters = favoriteCharacters
        delegate?.handleUpdatedCharacters()
    }
    
    func toggleFavorite(for character: Character) {
        let toggledCharacter = favoriteCharacterManager.toggleFavorite(for: character)
    }
}
