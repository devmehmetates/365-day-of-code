//
//  WrappingUIViews.swift
//  Instafilter
//
//  Created by Mehmet Ateş on 27.05.2022.
//

import SwiftUI

struct WrappingUIViews: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
}

struct WrappingUIViews_Previews: PreviewProvider {
    static var previews: some View {
        WrappingUIViews()
    }
}
