//
//  Expenses.swift
//  iExpense
//
//  Created by Mehmet Ateş on 1.05.2022.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try?  JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
            
            setTotalAmount()
        }
    }
    
    @Published var totalAmount: Double = 0.0
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                setTotalAmount()
                return
            }
        }
        
        items = []
    }
    
    func setTotalAmount(){
        totalAmount = 0
        
        for item in items{
            totalAmount += item.amount
        }
    }
}
