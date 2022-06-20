//
//  SpecificAccessibility .swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct SpecificAccessibility_: View {
    
    // MARK: Without color
//    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
//
//    var body: some View {
//        HStack {
//            if differentiateWithoutColor {
//                Image(systemName: "checkmark.circle")
//            }
//
//            Text("Success")
//        }
//        .padding()
//        .background(differentiateWithoutColor ? .black : .green)
//        .foregroundColor(.white)
//        .clipShape(Capsule())
//    }
    
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
//    @State private var scale = 1.0

//    var body: some View {
        
        // MARK: Optional Animation
//        Text("Hello, World!")
//            .scaleEffect(scale)
//            .onTapGesture {
//                if reduceMotion {
//                    scale *= 1.5
//                } else {
//                    withAnimation {
//                        scale *= 1.5
//                    }
//                }
//            }
//        Text("Hello, World!")
//            .scaleEffect(scale)
//            .onTapGesture {
//                withOptionalAnimation {
//                    scale *= 1.5
//                }
//            }
//       }
            
    // MARK: Transparency
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
    
}

struct SpecificAccessibility__Previews: PreviewProvider {
    static var previews: some View {
        SpecificAccessibility_()
    }
}
