//
//  ValidateAndDisable.swift
//  CupcakeCorner
//
//  Created by Mehmet Ateş on 13.05.2022.
//

import SwiftUI

struct ValidateAndDisable: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(disableForm)
            
        }
    }
}

struct ValidateAndDisable_Previews: PreviewProvider {
    static var previews: some View {
        ValidateAndDisable()
    }
}
