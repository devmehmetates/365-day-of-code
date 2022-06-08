//
//  MainView.swift
//  NewFeaturesOnSwiftUI
//
//  Created by Mehmet Ateş on 7.06.2022.
//

import SwiftUI

struct MainView: View {
    @State private var navigationPath: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Form {
                NavigationLink {
                    UsignSheets()
                } label: {
                    Text("Sheets")
                }
                NavigationLink {
                    UsignFixedGrids()
                } label: {
                    Text("Fixed grids")
                }
                NavigationLink {
                    UsignDetectUserTouchLocation()
                } label: {
                    Text("Detecting user touch location")
                }
            }.navigationTitle("What's the new on SwiftUI!")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
