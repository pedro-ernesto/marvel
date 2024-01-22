//
//  LocalStorage.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/22/24.
//

import Foundation

protocol LocalStorage {
    associatedtype Item
    associatedtype Key where Key: Hashable
    
    func getItem(with key: Key) -> Item?
    
    func getItems() -> [Key: Item]?
    
    func isItemSaved(key: Key) -> Bool
    
    func saveItem(with key: Key, for item: Item)
    
    func removeItem(with key: Key)
}
