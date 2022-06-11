//
//  ImageDetail-ViewModel.swift
//  ObjectPhotoList
//
//  Created by Mehmet Ateş on 11.06.2022.
//

import Foundation
import MapKit

extension ImageDetailView{
    @MainActor class ImageDetailViewModel: ObservableObject{
        @Published var mapReady: Bool = false
        @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        
        func setMapRegion(_ object: ObjectModel){
            self.mapRegion.center = CLLocationCoordinate2D(latitude: object.locationLatitude, longitude: object.locationLongitude)
            self.mapReady = true
        }
    }
}
