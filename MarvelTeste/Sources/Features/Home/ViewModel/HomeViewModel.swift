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
    
    private func handleGetCharactersResponse(_ result: Result<[Character], Error>) -> [Character]? {
        switch result {
        case .success(let characters):
            return characters
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
    
    func searchCharacters(with name: String) -> [Character]? {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (trimmedName.isEmpty) {
            return self.characters
        } else {
            let filteredCharacters = self.characters.filter { $0.name?.trimmingCharacters(in: .whitespacesAndNewlines).contains(name) ?? false}

            return filteredCharacters
        }
    }
    
    func toggleFavorite(for selectedCharacter: Character) {
        guard let characterIndex = self.characters.firstIndex(where: { $0.id == selectedCharacter.id }) else {
            print("Could not find character")
            return
        }
        self.characters[characterIndex].isFavorite.toggle()
        self.delegate?.handleUpdatedCharacters(characters)
        saveFavoriteCharacterLocally(characters[characterIndex])
    }
    
    private func saveFavoriteCharacterLocally (_ character: Character) {
        
    }

}
