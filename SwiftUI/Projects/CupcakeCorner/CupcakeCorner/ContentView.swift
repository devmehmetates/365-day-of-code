//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Mehmet Ateş on 13.05.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pageViewModel = OrderVieModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $pageViewModel.order.type) {
                        ForEach(OrderVieModel.types.indices) {
                            Text(OrderVieModel.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(pageViewModel.order.quantity)", value: $pageViewModel.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $pageViewModel.order.specialRequestEnabled.animation())
                    
                    if pageViewModel.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $pageViewModel.order.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $pageViewModel.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(pageViewModel: pageViewModel)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


