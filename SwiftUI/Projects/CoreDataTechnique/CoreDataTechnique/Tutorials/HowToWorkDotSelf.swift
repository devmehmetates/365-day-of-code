//
//  HowToWorkDotSelf.swift
//  CoreDataTechnique
//
//  Created by Mehmet Ateş on 21.05.2022.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}


struct HowToWorkDotSelf: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
    
    var body: some View {
        VStack{
            List {
                ForEach([2, 4, 6, 8, 10], id: \.self) {
                    Text("\($0) is even")
                }
            }
            List(students, id: \.self) { student in
                Text(student.name)
            }
        }

    }
}

struct HowToWorkDotSelf_Previews: PreviewProvider {
    static var previews: some View {
        HowToWorkDotSelf()
    }
}

