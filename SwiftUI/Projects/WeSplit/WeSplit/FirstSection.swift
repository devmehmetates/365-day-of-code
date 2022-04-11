//
//  FirstSection.swift
//  WeSplit
//
//  Created by Mehmet Ateş on 11.04.2022.
//

import SwiftUI

struct FirstSection: View {
    var body: some View {
        NavigationView{
            Form{
                Section {
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                }
                
                Section {
                    Text("Hello, world!")
                    Text("Hello, world!")
                }
            }.navigationTitle("Form")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FirstSection_Previews: PreviewProvider {
    static var previews: some View {
        FirstSection()
    }
}
