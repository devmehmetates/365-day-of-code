//
//  FilteredList.swift
//  CoreDataTechnique
//
//  Created by Mehmet Ateş on 21.05.2022.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(filterKey: String, filterValue: String, predicateValue: PredicateValues, sortDescriptor: NSSortDescriptor, @ViewBuilder content: @escaping (T) -> Content) {
        if filterValue.isEmpty{
            print("Hi")
            _fetchRequest = FetchRequest<T>(sortDescriptors: [])
        }else{
            _fetchRequest = FetchRequest<T>(sortDescriptors: [sortDescriptor], predicate: NSPredicate(format: "%K \(predicateValue.rawValue) %@", filterKey, filterValue))
        }
        self.content = content
    }
}


enum PredicateValues: String, CaseIterable{
    case BEGINSWITH
    case ENDSWITH
    case CONTAINS
    case LIKE
    case MATCHES
}
