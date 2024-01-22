//
//  ArrayExtensions.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/22/24.
//

import Foundation

extension Array {
    // if desired property from array exists as a key in passed dictionary, execute callback
    func ifProperty<U: Hashable>(_ keySelector: (Element) -> U, existsIn dictionary: [U: Any], do callback: (Element) -> Element) -> [Element] {
        var newArray: [Element] = []
        for element in self {
            let key = keySelector(element)
            if dictionary[key] != nil {
                let newElement = callback(element)
                newArray.append(newElement)
            } else {
                newArray.append(element)
            }
        }
        return newArray
    }
}
