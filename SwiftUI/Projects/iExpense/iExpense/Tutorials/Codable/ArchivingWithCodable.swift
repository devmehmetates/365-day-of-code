//
//  ArchivingWithCodable.swift
//  iExpense
//
//  Created by Mehmet Ateş on 30.04.2022.
//

import SwiftUI

struct CodableUser: Codable {
    let firstName: String
    let lastName: String
}

struct ArchivingWithCodable: View {
    @State private var user = CodableUser(firstName: "Tate", lastName: "McRae")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct ArchivingWithCodable_Previews: PreviewProvider {
    static var previews: some View {
        ArchivingWithCodable()
    }
}
