//
//  CharacterDetailsViewDelegate\.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/23/24.
//

import Foundation
import UIKit

public protocol CharacterDetailsViewDelegate: AnyObject {
    func handleShareCharacterImage(for character: Character)
    func handleFavoriteToggle()
    func handleShareAction(activityViewController: UIActivityViewController)
}
