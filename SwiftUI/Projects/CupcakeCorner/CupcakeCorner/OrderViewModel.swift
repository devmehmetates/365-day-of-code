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
    
    var cost: Double {
        // $2 per cake
        var cost = Double(order.quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(order.type) / 2)
        
        // $1/cake for extra frosting
        if order.extraFrosting {
            cost += Double(order.quantity)
        }
        
        // $0.50/cake for sprinkles
        if order.addSprinkles {
            cost += Double(order.quantity) / 2
        }
        
        return cost
    }
}

