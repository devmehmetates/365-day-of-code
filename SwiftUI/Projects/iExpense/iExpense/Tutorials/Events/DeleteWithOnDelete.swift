//
//  DeleteWithOnDelete.swift
//  iExpense
//
//  Created by Mehmet Ateş on 30.04.2022.
//

import SwiftUI

struct DeleteWithOnDelete: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }.onDelete(perform: removeRows)
                }
                //            List(numbers, id: \.self) {
                //                Text("Row \($0)")
                //            }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }.toolbar {
                EditButton()
            }.navigationTitle("Delete Items")
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct DeleteWithOnDelete_Previews: PreviewProvider {
    static var previews: some View {
        DeleteWithOnDelete()
    }
}
