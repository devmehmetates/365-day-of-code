//
//  AppMoves.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import SwiftUI

struct AppMoves: View {
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        Text("Hello, world!")
            .padding()
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

struct AppMoves_Previews: PreviewProvider {
    static var previews: some View {
        AppMoves()
    }
}
