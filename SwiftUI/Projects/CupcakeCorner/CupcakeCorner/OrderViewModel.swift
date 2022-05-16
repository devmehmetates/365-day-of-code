//
//  OrderViewModel.swift
//  CupcakeCorner
//
//  Created by Mehmet Ateş on 16.05.2022.
//

import Foundation

class OrderVieModel: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var order: Order = Order()

    
    var hasValidAddress: Bool {
        if order.name.isEmpty || order.streetAddress.isEmpty || order.streetAddress.replacingOccurrences(of: " ", with: "").isEmpty || order.city.isEmpty || order.zip.isEmpty {
            return false
        }
        
        return true
    }
}

