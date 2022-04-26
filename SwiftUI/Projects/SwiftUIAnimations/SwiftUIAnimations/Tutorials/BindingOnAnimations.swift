//
//  BindingOnAnimations.swift
//  SwiftUIAnimations
//
//  Created by Mehmet Ateş on 26.04.2022.
//

import SwiftUI

struct BindingOnAnimations: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                .repeatCount(1, autoreverses: true)
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }.padding()
    }
}

struct BindingOnAnimations_Previews: PreviewProvider {
    static var previews: some View {
        BindingOnAnimations()
    }
}
