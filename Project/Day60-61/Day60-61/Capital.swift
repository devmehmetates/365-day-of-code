//
//  Capital.swift
//  Day60-61
//
//  Created by Mehmet Ateş on 1.03.2022.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation  {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
