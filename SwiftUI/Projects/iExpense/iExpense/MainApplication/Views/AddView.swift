//
//  AddView.swift
//  iExpense
//
//  Created by Mehmet Ateş on 1.05.2022.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    @FocusState private var keyboardActive: Bool
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var currencyType = "USD"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    let currencyTypes = ["USD", "TRY", "EUR"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                    .autocapitalization(.none)
                
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
                
                Picker("Currency", selection: $currencyType){
                    ForEach(currencyTypes, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
                
                TextField("Amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($keyboardActive)
            }.navigationTitle("Add new expense")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save"){
                            let item = ExpenseItem(name: name, type: type, amount: amount, currency: currencyType)
                            expenses.items.append(item)
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .keyboard) {
                        Button("Done"){
                            keyboardActive.toggle()
                        }
                    }
                }
        }
    }

}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
