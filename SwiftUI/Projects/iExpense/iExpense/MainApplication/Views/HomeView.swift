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
    @State private var amountType: String = "All"
    
    private let amountTypes = ["All", "Personal", "Business"]
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    Text(expenses.totalAmount, format: .number)
                } header: {
                    Text("Your Total")
                } footer: {
                    InfoTexts(icon: "info.circle", title: "May be from different currency")
                }
                
                Section{
                    Picker("", selection: $amountType) {
                        ForEach(amountTypes, id: \.self) { amount in
                            Button(amount){
                                amountType = amount
                            }
                        }
                    }.pickerStyle(.segmented) 
                    
                    if setShowingItems().count == 0{
                        Text("No one spends. Wonderful!")
                    }else{
                        ForEach(setShowingItems()) { item in
                            HStack{
                                Image(systemName: setFieldStill(amount: item.amount).icon)
                                    .font(.caption)
                                    .foregroundColor(setFieldStill(amount: item.amount).color)
                                VStack(alignment: .leading){
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                        .accessibilityHint(item.type)
                                }.accessibilityLabel("name is \(item.name) and type is \(item.type)")
                                Spacer()
                                Text(item.amount, format: .currency(code: item.currency))
                            }
                            
                        }.onDelete(perform: removeItems)
                    }
                } header: {
                    Text("Your Expenses")
                } footer: {
                    VStack(alignment: .leading){
                        InfoTexts(icon: "checkmark.circle", title: "Everything is okay.")
                        InfoTexts(icon: "checkmark.circle.trianglebadge.exclamationmark", title: "Time to saving.")
                        InfoTexts(icon: "exclamationmark.triangle", title: "Danger zone. Enought!")
                    }
                }
                
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
    
    func removeItems(at indexSets: IndexSet) {
        let showingList = setShowingItems()
        
        let willRemoveItem = indexSets.compactMap({ showingList[$0] }).first
        
        let itemIndex = expenses.items.firstIndex { listItem in
            listItem.id == willRemoveItem?.id
        }
        
        if let itemIndex = itemIndex{
            expenses.items.remove(at: itemIndex)
        }
    }
    
    
    func setFieldStill(amount: Double) -> (color: Color, icon: String){
        if amount <= 10{
            return (color: .green, icon: "checkmark.circle")
        }else if amount <= 100{
            return (color: .yellow, icon: "checkmark.circle.trianglebadge.exclamationmark")
        }
        return (color: .red, icon: "exclamationmark.triangle")
    }
    
    func setShowingItems() -> [ExpenseItem]{
        if amountType == "Business"{
            return expenses.items.filter { item in
                item.type == "Business"
            }
        }else if amountType == "Personal"{
            return expenses.items.filter { item in
                item.type == "Personal"
            }
        }
        
        return expenses.items
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct InfoTexts: View{
    var icon: String
    var title: String
    var body: some View{
        HStack{
            Image(systemName: icon)
                .font(.caption2)
            Text(title)
        }
    }
}
