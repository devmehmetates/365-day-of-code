//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Mehmet Ateş on 14.05.2022.
//

import SwiftUI

struct CheckoutView: View {
    @State private var inProgress: Bool = false
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @ObservedObject var pageViewModel: OrderVieModel
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .accessibilityLabel("Cupcake Image")
                        .accessibilityRemoveTraits(.isImage)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(pageViewModel.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                
                Group{
                    if inProgress{
                        ProgressView()
                            .tint(.blue)
                    }else{
                        Button("Place Order") {
                            Task {
                                await placeOrder()
                            }
                        }
                        
                    }
                }.padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(confirmationTitle, isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        inProgress = true
        guard let encoded = try? JSONEncoder().encode(pageViewModel.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
       
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank You!"
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderVieModel.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            inProgress = false
        } catch {
            confirmationTitle = "Upps!"
            confirmationMessage = "Your order could not be received. Please try again!"
            showingConfirmation = true
            inProgress = false
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(pageViewModel: OrderVieModel())
    }
}
