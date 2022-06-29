//
//  SearchAbleView.swift
//  SnowSeeker
//
//  Created by Mehmet Ateş on 29.06.2022.
//

import SwiftUI

struct SearchAbleView: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

    var body: some View {
        NavigationView {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }

    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.contains(searchText) }
        }
    }}

struct SearchAbleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAbleView()
    }
}
