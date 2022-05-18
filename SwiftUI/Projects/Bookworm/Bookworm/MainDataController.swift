//
//  MainDataController.swift
//  Bookworm
//
//  Created by Mehmet Ateş on 18.05.2022.
//

import Foundation
import CoreData

class MainDataController: ObservableObject{
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        container.loadPersistentStores { description, err in
            if let err = err {
                print("Core data load error: \(err.localizedDescription)")
            }
        }
    }
    
}
