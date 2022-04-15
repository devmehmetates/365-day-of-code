//
//  ColorsAndFrames.swift
//  Guess the Flag
//
//  Created by Mehmet Ateş on 15.04.2022.
//

import SwiftUI

struct ColorsAndFrames: View {
    var body: some View {
        
        // MARK: Background properties
        ZStack{
            Text("Some content")
        }.background(.red)
        
        // MARK: Frames
        Color.red
            .frame(width: 200, height: 200, alignment: .center) // set content size
        Color.indigo
            .frame(minWidth: 100, maxWidth: .infinity, maxHeight: 200) // set content size flexible
            
        // MARK: Ignore safe area
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }
            
            Text("Your content")
                .foregroundColor(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }.ignoresSafeArea() // Overflow the safe area.
    }
}

struct Colors_and_frames_Previews: PreviewProvider {
    static var previews: some View {
        ColorsAndFrames()
    }
}
