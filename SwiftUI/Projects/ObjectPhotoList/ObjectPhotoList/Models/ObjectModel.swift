//
//  ObjectModel.swift
//  ObjectPhotoList
//
//  Created by Mehmet Ateş on 10.06.2022.
//

import Foundation

struct ObjectModel: Identifiable, Codable{
    var id = UUID()
    var name: String
    var imageData: Data
    var locationLongitude: Double
    var locationLatitude: Double
}
