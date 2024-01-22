//
//  HomeViewController.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/20/24.
//

import Foundation
import UIKit


class HomeViewController: UIViewController {
    private let contentView: HomeView
    private let viewModel: HomeViewModel
    
    //refactor into factory
    init(contentView: HomeView, viewModel: HomeViewModel = HomeViewModel()) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentView()
        self.viewModel.delegate = self
        self.contentView.delegate = self
        viewModel.getCharacters()
    }
    
    private func refreshCharactersList (with characters: [Character]) {
        print("characters")
        print(characters)
    }
    
    private func showErrorScreen (for error: Error) {
        print("error")
        print(error)
    }
        
    private func setupContentView() {
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.backgroundColor = .white
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func handleUpdatedCharacters(_ characters: [Character]) {
        if (characters.count == 0) {
            //update screen with empty list view
        } else {
            //update screen with new list of characters
            let dict = [1: characters[3], 2: characters[4], 3: characters[5], 1011297: characters[2]]
            
            // percorrer user Defaults e pegar as chaves
            // percorrer as chaves que vc quer comparar do characters
            
            
            let exists = characters.checkIfKeyExists(in: dict, keySelector: {$0.id}, keyExists: {
                print($0 ?? "ops")
            })
            print(exists)
            print(characters)
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    
    //navigate to details screen for selected character
    func handleCellAction(for character: Character) {
    
    }
    
    func handleFavoriteToggle(for character: Character) {
        viewModel.toggleFavorite(for: character)
    }
    
    func handleSearchAction(for name: String) {
        let filteredCharacters = viewModel.searchCharacters(with: name)
        //update view with filteredCharacters
    }
    
    //navigate to favorites screen
    func handleFavoritesAction() {
        
    }
}
