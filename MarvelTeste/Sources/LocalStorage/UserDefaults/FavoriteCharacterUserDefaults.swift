//
//  CharacterUserDefaults.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/22/24.
//

import Foundation

class FavoriteCharactersUserDefaults: LocalStorage {
    typealias Item = Character
    typealias Key = Int
    private let favoriteId: String = "favoriteId"
    private let tableKey: String = Keys.UserDefaults.characters
    
    func getItems() -> [Int: Character]? {
        guard let charactersData = getEncodedItems() else {
            return nil
        }
        
        var characters: [Int: Character] = [:]
        for (key, data) in charactersData {
            if let character = try? JSONDecoder().decode(Character.self, from: data) {
                characters[key] = character
            }
        }
        return characters
    }
    
    func getEncodedItems() -> [Int: Data]? {
        guard let items = UserDefaults.standard.dictionary(forKey: tableKey) as? [Int: Data] else {
            return nil
        }
        return items
    }
    
    func getItem(with key: Int) -> Character? {
        guard let characters = getItems() else {
            return nil
        }
        return characters[key]
    }
    
    
    func isItemSaved(key: Int) -> Bool {
        guard let characters = getItems() else {
            return false
        }
        return (characters[key] != nil) ? true : false
    }
    
    func saveItem(with key: Int, for item: Character) {
        var charactersDict = getEncodedItems() ?? [:]
        if let encodedItem = try? JSONEncoder().encode(item) {
            charactersDict[key] = encodedItem
            UserDefaults.standard.set(encodedItem, forKey: tableKey)
        }
    }
    
    func saveAllCharacters(_ characters: [Character]) {
        if let encodedItem = try? JSONEncoder().encode(characters) {
            UserDefaults.standard.set(encodedItem, forKey: tableKey)
        }
    }
    
    func getEncodedCharacters() -> Data? {
        guard let items = UserDefaults.standard.data(forKey: tableKey) else {
            return nil
        }
        return items
    }
    
    func getAllCharacters() -> [Character]? {
        guard let charactersData = getEncodedCharacters() else {
            return nil
        }
        
        let characters = try? JSONDecoder().decode([Character].self, from: charactersData)

        return characters
    }
    
    func saveFavoriteId(with id: Int) {
        guard var ids = getFavoriteId()  else {
            UserDefaults.standard.set([id], forKey: favoriteId)
            return
        }
        ids.append(id)
        UserDefaults.standard.set(ids, forKey: favoriteId)
        
        
    }
    
    func getFavoriteId() -> [Int]? {
        return UserDefaults.standard.array(forKey: favoriteId) as? [Int]
    }
    
    func removeFavoriteId (with key: Int) {
        guard var ids = getFavoriteId()  else {
            return
        }
        
        ids = ids.filter { $0 != key }
        
        UserDefaults.standard.set(ids, forKey: favoriteId)
        
    }
    
    func removeItem(with key: Int) {
        guard var characters = getEncodedItems() else {
            return
        }
        characters.removeValue(forKey: key)
        
        UserDefaults.standard.set(characters, forKey: tableKey)
    }
}
