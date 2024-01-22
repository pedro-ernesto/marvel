//
//  HomeViewModelDelegate.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func handleUpdatedCharacters(_ characters: [Character])
}
