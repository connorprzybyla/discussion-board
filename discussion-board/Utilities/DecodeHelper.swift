//
//  DecodeHelper.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/6/22.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to find \(file).")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to convert \(file) to Data.")
        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode \(file).")
        }
        
        return decodedData
    }
}
