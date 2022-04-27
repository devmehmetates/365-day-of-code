//
//  ModifierStackWithAnimations.swift
//  SwiftUIAnimations
//
//  Created by Mehmet Ateş on 27.04.2022.
//

import SwiftUI

struct ModifierStackWithAnimations: View {
    @State private var enabled = false
    
    var body: some View {
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .animation(nil, value: enabled)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
        .navigationTitle("Modifier Stack")
        
    }
}

struct ModifierStackWithAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ModifierStackWithAnimations()
    }
}
