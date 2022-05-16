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
}
