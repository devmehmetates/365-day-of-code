//
//  Readable Labels.swift
//  AccessibilityForiOS
//
//  Created by Mehmet Ateş on 7.06.2022.
//

import SwiftUI

struct Readable_Labels: View {
    let pictures = [
        "woman",
        "rose",
        "car",
    ]
    
    let labels = [
        "A woman under the some light research",
        "White rose with black background",
        "Bmw E92 in a street",
    ]

    @State private var selectedPicture = Int.random(in: 0...2)

    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFill()
            .frame(height: UIScreen.main.bounds.width * 0.7, alignment: .center)
            .clipped()
            .onTapGesture {
                selectedPicture = Int.random(in: 0...2)
            }
            .accessibilityLabel(labels[selectedPicture])
            .accessibilityAddTraits(.isButton)
            .accessibilityRemoveTraits(.isImage)
    }
}

struct Readable_Labels_Previews: PreviewProvider {
    static var previews: some View {
        Readable_Labels()
    }
}
