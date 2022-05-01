//
//  HomeView.swift
//  iExpense
//
//  Created by Mehmet Ateş on 1.05.2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var expenses = Expenses() // Use only on classes
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }.onDelete(perform: removeItems)
            }.navigationTitle("iExpense")
                .toolbar {
                    Button{
                        showingAddExpense.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddExpense, onDismiss: nil) {
                    AddView(expenses: expenses)
                }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
