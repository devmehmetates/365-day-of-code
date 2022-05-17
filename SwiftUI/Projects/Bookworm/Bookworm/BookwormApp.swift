//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Mehmet Ateş on 17.05.2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            CoreDataTutorialView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
