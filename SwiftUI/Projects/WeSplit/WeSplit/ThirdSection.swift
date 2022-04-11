//
//  ThirdSection.swift
//  WeSplit
//
//  Created by Mehmet Ateş on 11.04.2022.
//

import SwiftUI

struct ThirdSection: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
    }
}

struct ThirdSection_Previews: PreviewProvider {
    static var previews: some View {
        ThirdSection()
    }
}
