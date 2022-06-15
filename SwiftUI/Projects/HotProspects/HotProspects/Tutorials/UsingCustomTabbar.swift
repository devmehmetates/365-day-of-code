//
//  UsingCustomTabbar.swift
//  HotProspects
//
//  Created by Mehmet Ateş on 15.06.2022.
//

import SwiftUI

struct UsingCustomTabbar: View {
    @StateObject var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }.environmentObject(prospects)
    }
}

struct UsingCustomTabbar_Previews: PreviewProvider {
    static var previews: some View {
        UsingCustomTabbar()
    }
}
