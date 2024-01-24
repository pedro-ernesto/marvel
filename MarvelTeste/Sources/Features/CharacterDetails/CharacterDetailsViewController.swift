//
//  CharacterDetailsViewController.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation
import UIKit

class CharacterDetailsViewController: UIViewController {
    private let contentView: CharacterDetailsView
    private let viewModel: CharacterDetailsViewModel
    private var character: Character
    
    init(character: Character) {
        let contentView = CharacterDetailsView()
        let viewModel  = CharacterDetailsViewModel()
        
        self.character = character
        self.viewModel = viewModel
        self.contentView = contentView
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentView()
        setupNavBar()
        self.contentView.delegate = self
        setupViewData()
    }
    
    private func setupNavBar() {
        self.title = "Detalhes"
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.modalPresentationStyle = .fullScreen
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        view.backgroundColor = .white
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.backgroundColor = .white
    }
    
    private func setupViewData() {
        self.contentView.setupCharacterImage(character: character)
        self.contentView.setName(character.character.name ?? "Herói sem nome")
        self.contentView.setDescription(character.character.description ?? "Descricao nao encontrada")
        contentView.layoutSubviews()
    }
}

extension CharacterDetailsViewController: CharacterDetailsViewDelegate {
    func handleShareCharacterImage(for character: Character) {
        
    }
    
    func handleFavoriteToggle() {
        let character = viewModel.toggleFavorite(for: character)
        self.character = character
    }
    
    func handleShareAction(activityViewController: UIActivityViewController) {
        present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - Navigation

extension CharacterDetailsViewController {
    public func navigateToDetailsScreen() {
        //        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
