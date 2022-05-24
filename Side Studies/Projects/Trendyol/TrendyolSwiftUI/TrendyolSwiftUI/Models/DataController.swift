//
//  DataController.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 23.05.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Products")
    
    init(){
        container.loadPersistentStores { description, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
        }
        
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
}


