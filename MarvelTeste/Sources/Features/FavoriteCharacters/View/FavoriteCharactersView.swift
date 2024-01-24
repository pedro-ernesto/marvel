//
//  FavoriteCharactersView.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation
import UIKit

class FavoriteCharactersView: UIView {
    weak public var delegate: FavoriteCharactersViewDelegate?
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        self.accessibilityIdentifier = "favoriteCharactersView"
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
