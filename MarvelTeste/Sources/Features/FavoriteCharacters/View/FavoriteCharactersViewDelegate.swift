//
//  FavoriteCharactersViewDelegate.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/23/24.
//

import Foundation

protocol FavoriteCharactersViewDelegate: AnyObject {
    func handleCellAction(for character: Character)
    
    func handleFavoriteToggle(for character: Character)        
    func handleHomeAction()
    
}
