//
//  MultilineTextInputs.swift
//  Bookworm
//
//  Created by Mehmet Ateş on 17.05.2022.
//

import SwiftUI

struct MultilineTextInputs: View {
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct MultilineTextInputs_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextInputs()
    }
}
