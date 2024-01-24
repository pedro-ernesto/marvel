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
    init() {
        let contentView = HomeView()
        let viewModel = HomeViewModel()
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.contentView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        setupContentView()
        setupNavBar()
        viewModel.getCharacters()
    }
    
    private func setupNavBar() {
        self.title = "Detalhes"
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.modalPresentationStyle = .fullScreen
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

extension HomeViewController: HomeViewModelDelegate {
    func handleUpdatedCharacters() {
        if (viewModel.currentCharacters.count == 0) {
            //update screen with empty list view
        } else {
            self.contentView.tableView.reloadData()
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    
    //navigate to details screen for selected character
    func handleCellAction(for character: Character) {
        navigateToDetailsScreen(for: character)
    }
    
    func handleFavoriteToggle(for character: Character) {
        viewModel.toggleFavorite(for: character)
    }
    
    
    func handleSearchAction(for name: String) {
        viewModel.searchCharacters(with: name)
    }
    
    //navigate to favorites screen
    func handleFavoritesAction() {
        navigateToFavoritesScreen()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentCharacters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            return UITableViewCell()
        }
        let character = viewModel.currentCharacters[indexPath.row]
        cell.nameLabel.text = character.character.name
        cell.characterImageView.image = character.image
        cell.favoriteButton.isSelected = character.isFavorite
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        cell.favoriteButton.tag = indexPath.row
        return cell
    }

    @objc func favoriteButtonTapped(_ sender: UIButton) {
        let character = viewModel.currentCharacters[sender.tag]
        handleFavoriteToggle(for: character)
        sender.isSelected.toggle()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.currentCharacters[indexPath.row]
        handleCellAction(for: character)
    }
}

extension HomeViewController {
    public func navigateToDetailsScreen(for character: Character) {
        let viewController = CharacterDetailsViewController(character: character)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    public func navigateToFavoritesScreen() {
        let favoriteCharactersViewController = FavoriteCharactersViewController()
        navigationController?.pushViewController(favoriteCharactersViewController, animated: true)
    }
}
