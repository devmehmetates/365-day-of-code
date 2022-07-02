//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Mehmet Ateş on 1.07.2022.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        resorts = []
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(saveKey)
            
            do{
                let stringContent = try String(contentsOf: fileURL, encoding: .utf8)
                if let decoded = try? JSONDecoder().decode([String].self, from: stringContent.data(using: .utf8) ?? Data()) {
                    decoded.forEach { favResort in resorts.insert(favResort) }
                }
            } catch{ print("read error"); resorts = [] }
            return
        }
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(saveKey)
            
            do{
                if let encoded = try? JSONEncoder().encode(resorts) {
                    try encoded.write(to: fileURL)
                }
            } catch{ print("save error") }
        }
    }
}
