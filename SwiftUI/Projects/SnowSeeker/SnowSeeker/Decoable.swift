//
//  Decoable.swift
//  SnowSeeker
//
//  Created by Mehmet Ateş on 30.06.2022.
//

import Foundation

extension Bundle {
    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
    
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
