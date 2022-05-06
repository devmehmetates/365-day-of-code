//
//  Missions.swift
//  Moonshot
//
//  Created by Mehmet Ateş on 4.05.2022.
//

import Foundation

struct CrewRole: Codable{
    let name: String
    let role: String
}

struct Mission: Codable, Identifiable{
    let id: Int
    let launchDate: Date?
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var longFormattedLaunchDate: String { launchDate?.formatted(date: .complete, time: .complete) ?? "N/A" }
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
}
