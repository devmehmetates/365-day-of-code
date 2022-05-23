//
//  CoreDataTechniqueApp.swift
//  CoreDataTechnique
//
//  Created by Mehmet Ateş on 21.05.2022.
//

import SwiftUI

@main
struct CoreDataTechniqueApp: App {
    var dataController = ThirdDataController()
    
    var body: some Scene {
        WindowGroup {
            ThirdContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
