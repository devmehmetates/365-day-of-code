//
//  UsingContextMenu.swift
//  HotProspects
//
//  Created by Mehmet Ateş on 14.06.2022.
//

import SwiftUI

struct UsingContextMenu: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(role: .destructive) {
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                    }
//                    Button {
//                        backgroundColor = .red
//                    } label: {
//                        Label("Red", systemImage: "checkmark.circle.fill")
//                            .foregroundColor(.red)
//                    }
//
//                    Button("Red") {
//                        backgroundColor = .red
//                    }

                    Button("Green") {
                        backgroundColor = .green
                    }

                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

struct UsingContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        UsingContextMenu()
    }
}
