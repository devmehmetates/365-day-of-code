//
//  CoreDataTechniqueApp.swift
//  CoreDataTechnique
//
//  Created by Mehmet Ateş on 21.05.2022.
//

import SwiftUI

@main
struct CoreDataTechniqueApp: App {
    var dataController = MainDataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
