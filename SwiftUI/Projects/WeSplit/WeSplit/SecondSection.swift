//
//  SecondSection.swift
//  WeSplit
//
//  Created by Mehmet Ateş on 11.04.2022.
//

import SwiftUI

struct SecondSection: View {
    @State private var tabCount = 0
    @State private var name = ""
    
    var body: some View {
        Form{
            Button("Tab count: \(tabCount)"){
                self.tabCount += 1
            }
            TextField("Enter Your Name", text: $name)
            Text(name)
        }
        
    }
}

struct SecondSection_Previews: PreviewProvider {
    static var previews: some View {
        SecondSection()
    }
}
