//
//  Lists.swift
//  World Scramble
//
//  Created by Mehmet Ateş on 23.04.2022.
//

import SwiftUI

struct Lists: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        List {
            Text("Static Row")
            
            ForEach(people, id: \.self) {
                Text($0)
            }
            
            Text("Static Row")
        }.listStyle(.grouped)
    }
}

struct Lists_Previews: PreviewProvider {
    static var previews: some View {
        Lists()
    }
}
