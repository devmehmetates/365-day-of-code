//
//  PropertyWrappers.swift
//  Instafilter
//
//  Created by Mehmet Ateş on 26.05.2022.
//

import SwiftUI

struct PropertyWrappers: View {
    @State private var blurAmount = 0.0
//    {
//        didSet {
//            print("New value is \(blurAmount)")
//        }
//    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }.onChange(of: blurAmount) { newValue in
            print("New value is \(newValue)")
        }
    }
}

struct PropertyWrappers_Previews: PreviewProvider {
    static var previews: some View {
        PropertyWrappers()
    }
}
