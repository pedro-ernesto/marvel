//
//  FavoriteCharactersViewController.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation
import UIKit

class FavoriteCharactersViewController: UIViewController {
    private let contentView: FavoriteCharactersView
    private let viewModel: FavoriteCharactersViewModel
    
    init () {
        let contentView = FavoriteCharactersView()
        let viewModel = FavoriteCharactersViewModel()
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
        contentView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        viewModel.delegate = self
        viewModel.getFavoriteCharacters()
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.backgroundColor = .white
    }
}

extension FavoriteCharactersViewController: FavoriteCharactersViewDelegate {
    //navigate to details
    func handleCellAction(for character: Character) {
        navigateToDetailsScreen(for: character)
    }
    
    func handleFavoriteToggle(for character: Character) {
        viewModel.toggleFavorite(for: character)
        viewModel.getFavoriteCharacters()
    }
    
    //navigate to home
    func handleHomeAction() {
        
    }
}

extension FavoriteCharactersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            return UITableViewCell()
        }
        let character = viewModel.characters[indexPath.row]
        cell.nameLabel.text = character.character.name
        cell.characterImageView.image = character.image
        cell.favoriteButton.isSelected = character.isFavorite // Update button state based on isFavorite
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        cell.favoriteButton.tag = indexPath.row
        return cell
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        let character = viewModel.characters[sender.tag]
        handleFavoriteToggle(for: character)
        sender.isSelected.toggle()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        handleCellAction(for: character)
    }
}

extension FavoriteCharactersViewController: FavoriteCharactersViewModelDelegate {
    func handleUpdatedCharacters() {
        contentView.tableView.reloadData()
    }
}

extension FavoriteCharactersViewController {
    public func navigateToDetailsScreen(for character: Character) {
        let viewController = CharacterDetailsViewController(character: character)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func navigateToHomeScreen() {
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}
