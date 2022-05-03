//
//  PushingNewVies.swift
//  Moonshot
//
//  Created by Mehmet Ateş on 3.05.2022.
//

import SwiftUI

struct PushingNewVies: View {
    var body: some View {
        NavigationView{
            List{
                ForEach(0..<100){ row in
                    NavigationLink{
                        Text("Detail \(row)")
                    } label: {
                        Text("Row: \(row)")
                    }
                }
            }.navigationTitle("SwiftUI Navigations")
        }
    }
}

struct PushingNewVies_Previews: PreviewProvider {
    static var previews: some View {
        PushingNewVies()
    }
}
