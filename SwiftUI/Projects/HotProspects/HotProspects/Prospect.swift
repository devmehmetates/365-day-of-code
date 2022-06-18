//
//  Prospect.swift
//  HotProspects
//
//  Created by Mehmet Ateş on 15.06.2022.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var creatingDate = Date.now
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    @Published var sortingSelection: Int = 0{
        didSet{
            sortByType()
        }
    }
    let saveKey = "SavedData.txt"
    

    init() {
        people = []
        readData()
        sortByType()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        saveData()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        saveData()
    }
    
    func saveData(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(saveKey)
            
            do{
                if let encoded = try? JSONEncoder().encode(people) {
                    try encoded.write(to: fileURL)
                }
            } catch{ print("save error") }
        }
    }
    
    func readData(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(saveKey)
            
            do{
                let stringContent = try String(contentsOf: fileURL, encoding: .utf8)
                if let decoded = try? JSONDecoder().decode([Prospect].self, from: stringContent.data(using: .utf8) ?? Data()) {
                    people = decoded
                }
            } catch{ print("read error"); people = [] }
        }
    }
    
    func sortByType(){
        if sortingSelection == 0{ // Most Recent
            people.sort { $0.creatingDate > $1.creatingDate }
        } else{ // By Name
            people.sort { $0.name > $1.name }
        }
    }
}
