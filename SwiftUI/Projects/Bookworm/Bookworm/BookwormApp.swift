//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Mehmet Ateş on 17.05.2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = MainDataController()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
