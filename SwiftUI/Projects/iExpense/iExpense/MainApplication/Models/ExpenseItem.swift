//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Mehmet Ateş on 1.05.2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
