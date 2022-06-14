//
//  AddingPackages.swift
//  HotProspects
//
//  Created by Mehmet Ateş on 14.06.2022.
//

import SwiftUI
import SamplePackage

struct AddingPackages: View {
    let possibleNumbers = Array(1...60)
    
    var body: some View {
        Text(results)
    }
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
}

struct AddingPackages_Previews: PreviewProvider {
    static var previews: some View {
        AddingPackages()
    }
}
