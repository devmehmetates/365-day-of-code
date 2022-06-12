//
//  UsingTabView.swift
//  HotProspects
//
//  Created by Mehmet Ateş on 12.06.2022.
//

import SwiftUI

struct UsingTabView: View {
    @State private var selectedTab = "One"

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .tag("One")

            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

struct UsingTabView_Previews: PreviewProvider {
    static var previews: some View {
        UsingTabView()
    }
}
