//
//  UsignSheets.swift
//  NewFeaturesOnSwiftUI
//
//  Created by Mehmet Ateş on 7.06.2022.
//

import SwiftUI

struct UsignSheets: View {
    @State private var showingMediumLarge = false
    @State private var showingSpecific = false
    @State private var showingfraction = false

    var body: some View {
        Form{
            Button("Trigger medium-large") { showingMediumLarge.toggle() }
            Button("Trigger specific") { showingSpecific.toggle() }
            Button("Trigger fraction") { showingfraction.toggle() }
        }.sheet(isPresented: $showingMediumLarge) {
            Text("This is a medium-large sheet")
                .presentationDetents([.medium, .large])
        }.sheet(isPresented: $showingSpecific) {
            Text("This is a specific sheet")
                .presentationDetents([.height(300)])
        }.sheet(isPresented: $showingfraction) {
            Text("This is a fraction sheet")
                .presentationDetents([.fraction(0.7)]) // 1 is full screen and 0.5 half screen
        }
    }
}

struct UsignSheets_Previews: PreviewProvider {
    static var previews: some View {
        UsignSheets()
    }
}
