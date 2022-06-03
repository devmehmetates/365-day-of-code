//
//  MainLocation.swift
//  BucketList
//
//  Created by Mehmet Ateş on 3.06.2022.
//

import Foundation
import MapKit

struct MainLocation: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = MainLocation(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis.", latitude: 51.501, longitude: -0.141)
    
    static func ==(lhs: MainLocation, rhs: MainLocation) -> Bool {
        lhs.id == rhs.id
    }
}
