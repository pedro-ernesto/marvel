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
    private let tableKey: String = Keys.UserDefaults.characters
    
    func getItem(with key: Int) -> Character? {
        guard let characters = getItems() else {
            return nil
        }
        return characters[key]
    }
    
    func getItems() -> [Int: Character]? {
        return UserDefaults.standard.dictionary(forKey: tableKey) as? [Int: Character]
    }
    
    func isItemSaved(key: Int) -> Bool {
        guard let characters = getItems() else {
            return false
        }
        return (characters[key] != nil) ? true : false
    }
    
    func saveItem(with key: Int, for item: Character) {
         guard var characters = getItems() else {
             let dict = [key: item]
            UserDefaults.standard.set(dict, forKey: tableKey)
            return
        }
        characters[key] = item
        UserDefaults.standard.set(characters, forKey: tableKey)
    }
    
    func removeItem(with key: Int) {
        guard var characters = getItems() else {
            return
       }
        characters.removeValue(forKey: key)
        
        UserDefaults.standard.set(characters, forKey: tableKey)
    }
}
