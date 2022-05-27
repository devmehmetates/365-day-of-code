//
//  ShowingMultipleOptions.swift
//  Instafilter
//
//  Created by Mehmet Ateş on 26.05.2022.
//

import SwiftUI

struct ShowingMultipleOptions: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingConfirmation = true
            }.confirmationDialog("Change background", isPresented: $showingConfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color")
            }
    }
}

struct ShowingMultipleOptions_Previews: PreviewProvider {
    static var previews: some View {
        ShowingMultipleOptions()
    }
}
