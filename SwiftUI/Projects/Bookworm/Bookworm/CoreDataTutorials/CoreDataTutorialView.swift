//
//  CoreDataTutorialView.swift
//  Bookworm
//
//  Created by Mehmet Ateş on 17.05.2022.
//

import SwiftUI

struct CoreDataTutorialView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack{
            List(students){ student in
                Text(student.name ?? "Unknow")
            }
            
            Button("add"){
                let firstNames = ["Tate", "Maggie", "Taylor"]
                let lastNames = ["McRae", "Linderman", "Swift"]
                
                let chosenRandomFirstName = firstNames.randomElement()!
                let chosenRandomLastName = lastNames.randomElement()!
                
                let student = Student(context: moc)
                student.id = UUID()
                student.name = "\(chosenRandomFirstName) \(chosenRandomLastName)"
                
                try? moc.save()
            }
        }
    }
}

struct CoreDataTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataTutorialView()
    }
}
