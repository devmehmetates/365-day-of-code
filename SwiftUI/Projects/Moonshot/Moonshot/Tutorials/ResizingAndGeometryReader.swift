//
//  ResizingAndGeometryReader.swift
//  Moonshot
//
//  Created by Mehmet Ateş on 3.05.2022.
//

import SwiftUI

struct ResizingImageTypes: View {
    var body: some View {
        VStack{
            Text("All images have 100x100 frames")
            Section{
                Image("Example")
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipped()
            } footer: {
                Text("Only Clipped")
                    .font(.caption)
            }
            
            Section{
                Image("Example")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
            } footer: {
                Text("ScaledToFit")
                    .font(.caption)
            }
            
            Section{
                Image("Example")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment: .center)
            } footer: {
                Text("ScaledToFill")
                    .font(.caption)
            }

            Section{
                Image("Example")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipped()
            } footer: {
                Text("ScaledToFill and Clipped")
                    .font(.caption)
            }

            
            Section{
                Image("Example")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipped()
            } footer: {
                Text("Resized and Clipped")
                    .font(.caption)
            }
            
           

            
            
            
           
            
            }
    }
}

struct ResizingAndGeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        ResizingImageTypes()
    }
}

struct GeomertryReaderUsage: View{
    var body: some View{
        GeometryReader{ proxy in
            Image("Example")
                .resizable()
                .scaledToFit()
                .frame(width: proxy.size.width * 0.9)
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            
        }

    }
}
