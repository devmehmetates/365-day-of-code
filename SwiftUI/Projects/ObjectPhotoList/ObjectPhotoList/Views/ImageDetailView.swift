//
//  ImageDetailView.swift
//  ObjectPhotoList
//
//  Created by Mehmet Ateş on 11.06.2022.
//

import SwiftUI
import MapKit

struct ImageDetailView: View {
    @ObservedObject private var viewModel: ImageDetailViewModel = ImageDetailViewModel()
    private var object: ObjectModel
    
    init(object: ObjectModel){
        self.object = object
        viewModel.setMapRegion(object)
    }
    
    var body: some View {
        if viewModel.mapReady{
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: [object]){ object in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: object.locationLatitude, longitude: object.locationLongitude)) {
                    VStack {
                        Image(uiImage: UIImage(data: object.imageData)!)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                            .overlay(Circle().stroke(lineWidth: 1).foregroundColor(.white))
                        Text(object.name)
                            .fixedSize()
                    }
                }
            }.ignoresSafeArea()
        }else{
            VStack{
                ProgressView()
            }
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(object: ObjectModel(name: "deneme", imageData: Data(), locationLongitude: 10, locationLatitude: 10))
    }
}
