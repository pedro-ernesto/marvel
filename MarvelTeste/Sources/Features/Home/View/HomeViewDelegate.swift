//
//  HomeViewDelegate.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/20/24.
//

import Foundation

import Foundation

protocol HomeViewDelegate: AnyObject {
    func handleCellAction(for character: Character)
    
    func handleFavoriteToggle(for character: Character)
    
    func handleSearchAction(for name: String)
    
    func handleFavoritesAction()
}
