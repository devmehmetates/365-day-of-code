//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Mehmet Ateş on 14.05.2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var pageViewModel: OrderVieModel
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $pageViewModel.order.name)
                TextField("Street Address", text: $pageViewModel.order.streetAddress)
                TextField("City", text: $pageViewModel.order.city)
                TextField("Zip", text: $pageViewModel.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(pageViewModel: pageViewModel)
                } label: {
                    Text("Check out")
                }
            }.disabled(pageViewModel.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(pageViewModel: OrderVieModel())
    }
}
