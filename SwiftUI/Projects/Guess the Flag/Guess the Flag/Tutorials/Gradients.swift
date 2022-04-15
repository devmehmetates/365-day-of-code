//
//  Gradients.swift
//  Guess the Flag
//
//  Created by Mehmet Ateş on 15.04.2022.
//

import SwiftUI

struct Gradients: View {
    var body: some View {
        Form{
            Section{
                LinearGradient(gradient: Gradient(stops:[
                    .init(color: .red, location: 0.45), // where is the stops point for this color? -> 0.45 (0 is start, 1 is end)
                    .init(color: .indigo, location: 0.55),
                ]), startPoint: .trailing, endPoint: .leading) // start point and end point for gradient
            } footer: {
                Text("Linear gradient") // Most populer gradient type.
            }
            
            Section{
                RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
                // a radius to expand and a radius to limit
            } footer: {
                Text("Radial Gradient")
            }
            
            Section{
                AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                // a point for beginning the color scale
            } footer: {
                Text("Angular Gradient")
            }
        }
    }
}

struct Gradients_Previews: PreviewProvider {
    static var previews: some View {
        Gradients()
    }
}
