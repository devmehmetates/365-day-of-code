//
//  HierachicalCodableData.swift
//  Moonshot
//
//  Created by Mehmet Ateş on 3.05.2022.
//

import SwiftUI

struct User: Codable{
    let name: String
    let surname: String
    let address: Address
    
    // MARK: Extra section
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case surname = "surname"
        case address = "full_address"
    }
}


struct Address: Codable{
    let street: String
    let city: String
}

struct HierachicalCodableData: View {
    @State private var nameAndSurname: String = ""
    @State private var address: String = ""
    
    var body: some View {
        VStack{
            Button("Decode Json"){
                let input = """
                    {
                        "name": "Tate",
                        "surname" : "McRae",
                        "full_address": {
                            "street": "Canada, House",
                            "city": "Ottowa"
                        }
                    }
                """
                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(User.self, from: data){
                    nameAndSurname = user.name + " " + user.surname
                    address = user.address.city + " " + user.address.street
                }else{
                    nameAndSurname = "Unfortinately this file is not decoded"
                }
            }
            
            Text("User: \(nameAndSurname)")
            Text("Address: \(address)")
            
        }
    }
}

struct HierachicalCodableData_Previews: PreviewProvider {
    static var previews: some View {
        HierachicalCodableData()
    }
}
