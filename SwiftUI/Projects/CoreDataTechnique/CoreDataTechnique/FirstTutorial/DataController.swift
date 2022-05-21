//
//  DataController.swift
//  CoreDataTechnique
//
//  Created by Mehmet Ateş on 21.05.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "CoreDataTechniqueModel")
    
    init(){
        container.loadPersistentStores { description, err in
            if let err = err {
                print("Core data load error: \(err.localizedDescription)")
            }
        }
    }
    
}
