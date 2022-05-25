//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 24.05.2022.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    var offlineDataController = OfflineDataController()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, offlineDataController.container.viewContext)
        }
    }
}
