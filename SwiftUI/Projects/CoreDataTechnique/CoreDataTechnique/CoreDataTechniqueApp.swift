//
//  CoreDataTechniqueApp.swift
//  CoreDataTechnique
//
//  Created by Mehmet Ateş on 21.05.2022.
//

import SwiftUI

@main
struct CoreDataTechniqueApp: App {
    var dataController = FourthDataController()
    
    var body: some Scene {
        WindowGroup {
            FourthContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
