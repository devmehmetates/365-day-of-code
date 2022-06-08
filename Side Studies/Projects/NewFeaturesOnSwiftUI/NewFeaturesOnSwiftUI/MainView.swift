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
                Section("Modified"){
                    NavigationLink {
                        UsignSheets()
                    } label: {
                        Text("Sheets")
                    }
                }
                Section("Fully New"){
                    NavigationLink {
                        UsignFixedGrids()
                    } label: {
                        Text("Grid Row")
                    }
                    NavigationLink {
                        UsignDetectUserTouchLocation()
                    } label: {
                        Text("Detecting user touch location")
                    }
                    NavigationLink {
                        UsingSwiftUICharts()
                    } label: {
                        Text("SwiftUI Charts(Module)")
                    }
                    NavigationLink {
                        UsingShareSheet()
                    } label: {
                        Text("Share Sheet")
                    }
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
