//
//  CharacterDetailsView.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation
import UIKit

public class CharacterDetailsView: UIView {
    public weak var delegate: CharacterDetailsViewDelegate?
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitle("Compartilhar", for: .normal)
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func shareTapped() {
        var activityItems: [Any] = []
        
        
        
        // Check if the character's image is available and add it to the share items
        if let characterImage = characterImageView.image {
            activityItems.append(characterImage)
        }
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        self.delegate?.handleShareAction(activityViewController: activityViewController)
    }
    
    
    
    private lazy var characterForm = CharacterForm(nameLabel: "",
                                                   description: "")
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favoritar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Inicializadores
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapButton() {
        self.delegate?.handleFavoriteToggle()
    }
    
    private func setupUI() {
        addSubview(characterImageView)
        addSubview(characterForm)
        addSubview(favoriteButton)
        addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.Size.large),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Size.large),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Size.large),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),
            
            characterForm.topAnchor.constraint(equalTo: centerYAnchor, constant: Metrics.Size.medium),
            characterForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Size.medium),
            characterForm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Size.medium),
            
            favoriteButton.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -Metrics.Size.large),
            favoriteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Size.medium),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Size.medium),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44),
            
            shareButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.Size.large),
            shareButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Size.medium),
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Size.medium),
            shareButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    public func setupCharacterImage(character: Character) {
        characterImageView.image = character.image ?? #imageLiteral(resourceName: "notAvailableImage.jpeg")
        
    }
    
    public func setName(_ name: String) {
        characterForm.setNameLabel(name)
    }
    
    public func setDescription(_ description: String) {
        characterForm.setDescriptionLabel(description)
    }
}
