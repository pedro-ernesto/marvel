//
//  CharacterForm.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/23/24.
//

import Foundation
import UIKit

public class CharacterForm: UIView {
    
    public init(nameLabel: String, description: String? = "") {
        super.init(frame: .zero)
        
        setupUI()
        setNameLabel(nameLabel)
        setDescriptionLabel(description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 18/255, green: 0/255, blue: 82/255, alpha: 1.0)
        //trocar para arquivo de colors
        label.font = UIFont.boldSystemFont(ofSize: Metrics.Fonts.titleFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Metrics.Fonts.descriptionFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.Size.medium),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Size.medium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Size.medium),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.Size.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Size.medium),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Size.medium),
        ])
    }
    
    public func setNameLabel(_ name: String) {
        titleLabel.text = name
    }
    
    public func setDescriptionLabel(_ description: String?) {
        descriptionLabel.text = description
    }
}
