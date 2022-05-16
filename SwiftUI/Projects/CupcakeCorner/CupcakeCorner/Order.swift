//
//  Order.swift
//  CupcakeCorner
//
//  Created by Mehmet Ateş on 14.05.2022.
//

import Foundation

struct Order: Codable{
     var type = 0
     var quantity = 3
    
     var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
     var extraFrosting = false
     var addSprinkles = false
    
     var name = ""
     var streetAddress = ""
     var city = ""
     var zip = ""
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
