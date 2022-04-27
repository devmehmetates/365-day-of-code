//
//  ShowAndHideWithTransitions.swift
//  SwiftUIAnimations
//
//  Created by Mehmet Ateş on 27.04.2022.
//

import SwiftUI

struct ShowAndHideWithTransitions: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .slide))
            }
        }.navigationTitle("Transitions animations")
    }
}

struct ShowAndHideWithTransitions_Previews: PreviewProvider {
    static var previews: some View {
        ShowAndHideWithTransitions()
    }
}
