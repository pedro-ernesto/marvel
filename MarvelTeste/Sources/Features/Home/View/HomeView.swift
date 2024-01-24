//
//  HomeView\.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/20/24.
//

import Foundation
import UIKit

class HomeView: UIView {
    // MARK - VARIABLES
    weak public var delegate: HomeViewDelegate?
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.accessibilityIdentifier = "charactersList"
        return table
    }()
    private lazy var favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Favorites", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        button.accessibilityIdentifier = "favoritesButton"
        return button
    }()
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search characters"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "searchInput"
        return textField
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.accessibilityIdentifier = "searchButton"
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK - SETUP
    
    private func setup() {
        setViewHierarchy()
        setConstraints()
    }
    
    // MARK - PRIVATE FUNCTIONS
    
    private func setViewHierarchy() {
        self.accessibilityIdentifier = "homeView"
        addSubview(searchTextField) // Add the text field
        addSubview(searchButton)
        addSubview(tableView)
        addSubview(favoritesButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            favoritesButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            favoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            searchTextField.topAnchor.constraint(equalTo: favoritesButton.bottomAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            searchButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func favoritesButtonTapped() {
        delegate?.handleFavoritesAction()
    }
    
    @objc private func searchButtonTapped() {
        guard let searchText = searchTextField.text else {
            return
        }
        delegate?.handleSearchAction(for: searchText)
    }
}


