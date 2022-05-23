//
//  ThirdContentView.swift
//  CoreDataTechnique
//
//  Created by Mehmet Ateş on 21.05.2022.
//

import SwiftUI

struct ThirdContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var filterParam: String = ""
    @State private var sortParam: NSSortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
    @State private var sortContent: String = "firstName"
    @State private var predicateType: PredicateValues = .BEGINSWITH
    
    var body: some View {
        VStack {
            FilteredList(filterKey: sortContent, filterValue: filterParam, predicateValue: predicateType, sortDescriptor: sortParam) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                let tate = Singer(context: moc)
                tate.firstName = "Tate"
                tate.lastName = "McRae"
                
                try? moc.save()
            }
            
            HStack{
                Picker("predicateVALUE", selection: $predicateType) {
                    ForEach(PredicateValues.allCases, id: \.self) { predicateValue in
                        Text(predicateValue.rawValue)
                    }
                }.pickerStyle(.segmented)
            }.padding()
            
            HStack{
                Picker("predicateVALUE", selection: $sortContent) {
                    ForEach(["firstName","lastName"], id: \.self) { value in
                        Text(value.capitalized)
                    }
                }.pickerStyle(.segmented)
            }.padding(.horizontal)
            
            TextField("Filter", text: $filterParam)
                .padding(.horizontal)
        }
    }
}

struct ThirdContentView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdContentView()
    }
}
