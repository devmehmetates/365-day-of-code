//
//  NetworkImages.swift
//  CupcakeCorner
//
//  Created by Mehmet Ateş on 13.05.2022.
//

import SwiftUI

struct NetworkImages: View {
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)
            
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.red
            }
            .frame(width: 200, height: 200)
        }
        
    }
}

struct NetworkImages_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImages()
    }
}
