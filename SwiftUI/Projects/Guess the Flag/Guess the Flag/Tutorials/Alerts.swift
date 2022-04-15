//
//  Alerts.swift
//  Guess the Flag
//
//  Created by Mehmet Ateş on 15.04.2022.
//

import SwiftUI

struct Alerts: View {
    // a properties for trigger
    @State private var showAnAlert: Bool = false
    
    var body: some View {
        Button {
            showAnAlert.toggle() // trigger that properties
        } label: {
            Label("Show Alert", systemImage: "info.circle")
        }.alert("Important message", isPresented: $showAnAlert) { // here is the alert with title
            // contents of the alert
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            // message of the alert
            Text("Please read this.")
        }
    }
}

struct Alerts_Previews: PreviewProvider {
    static var previews: some View {
        Alerts()
    }
}
