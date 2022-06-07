//
//  Hiding AccesData.swift
//  AccessibilityForiOS
//
//  Created by Mehmet Ateş on 7.06.2022.
//

import SwiftUI

struct Hiding_AccesData: View {
    var body: some View {
        VStack{
            Image(decorative: "woman")
                .accessibilityHidden(true)
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Your score is 1000")
        }
        
    }
}

struct Hiding_AccesData_Previews: PreviewProvider {
    static var previews: some View {
        Hiding_AccesData()
    }
}
