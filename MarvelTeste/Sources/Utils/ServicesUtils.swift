//
//  ServicesUtils.swift
//  MarvelTeste
//
//  Created by Pedro Ernersto on 1/21/24.
//

import Foundation

struct ServicesUtils {
    static func decodeJson<T: Decodable>(from jsonData: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedData
        } catch {
            print("Error decoding Character: \(error)")
            return nil
        }
    }
}
