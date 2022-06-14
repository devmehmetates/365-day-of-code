//
//  UsingSwipeActions.swift
//  HotProspects
//
//  Created by Mehmet Ateş on 14.06.2022.
//

import SwiftUI

struct UsingSwipeActions: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button(role: .destructive) {
                        print("Hi")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Hi")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)
                }
        }
    }
}

struct UsingSwipeActions_Previews: PreviewProvider {
    static var previews: some View {
        UsingSwipeActions()
    }
}
