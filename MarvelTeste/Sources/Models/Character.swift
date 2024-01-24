//
//  Character.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation
import UIKit

public struct Character: Codable {
    var character: CharacterApiResponse.Character
    var imageData: Data?
    var isFavorite: Bool = false
    
    var image: UIImage? {
        get {
            guard let imageData = imageData else { return #imageLiteral(resourceName: "notAvailableImage.jpeg") }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
    
}

extension Character {
    var url: URL? {
        guard let path = character.thumbnail?.path, let `extension` = character.thumbnail?.`extension`, !path.isEmpty, !`extension`.isEmpty else {
            return nil
        }
        return URL(string: "\(path).\(`extension`)")
    }
}

extension Character {
    static func mock(id: Int = 1, name: String = "Homem Aranha", description: String = "aranha", isFavorite: Bool = false) -> Character {
        let thumbnail = CharacterApiResponse.Character.Image(path: "teste.com", extension: "jpg")
        let apiCharacter = CharacterApiResponse.Character(id: id, name: name, description: description, thumbnail: thumbnail)
        return Character(character: apiCharacter, isFavorite: isFavorite)
    }
}
