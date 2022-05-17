//
//  DataController.swift
//  Bookworm
//
//  Created by Mehmet Ateş on 17.05.2022.
//

import CoreData
import Foundation


class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        container.loadPersistentStores { description, err in
            if let err = err {
                print("Core data load error: \(err.localizedDescription)")
            }
        }
    }
    
}
