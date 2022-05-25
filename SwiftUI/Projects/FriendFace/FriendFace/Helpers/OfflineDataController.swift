//
//  OfflineDataController.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 25.05.2022.
//

import Foundation
import CoreData

class OfflineDataController: ObservableObject{
    let container = NSPersistentContainer(name: "OfflineModels")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
