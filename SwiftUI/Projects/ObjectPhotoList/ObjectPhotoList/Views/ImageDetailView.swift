//
//  ImageDetailView.swift
//  ObjectPhotoList
//
//  Created by Mehmet Ateş on 11.06.2022.
//

import SwiftUI

struct ImageDetailView: View {
    var image: Image
    var name: String
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .navigationTitle(name)
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(image: Image(systemName: "star"), name: "Star")
    }
}
