//
//  ButtonsAndImages.swift
//  Guess the Flag
//
//  Created by Mehmet Ateş on 15.04.2022.
//

import SwiftUI

struct ButtonsAndImages: View {
    var body: some View {
        VStack{
            // MARK: Classic iOS button
            Button("Delete selection"){
                // any delete func
            }
            
            // MARK: Classic iOS button but with destructive looks
            Button("Delete selection", role: .destructive, action: deleteElement)
            
            
            // MARK: Buttons with styles
            VStack {
                Button("Button 1") { }
                    .buttonStyle(.bordered)
                Button("Button 2", role: .destructive) { }
                    .buttonStyle(.bordered)
                Button("Button 3") { }
                    .buttonStyle(.borderedProminent)
                    .tint(.mint) // change button color from .accent to whatever you want
                Button("Button 4", role: .destructive) { }
                    .buttonStyle(.borderedProminent)
            }
            
            // MARK: Button with label
            Button {
                print("Edit button was tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
            }.foregroundStyle(.indigo)
        }
    }
    
    func deleteElement(){
        print("Deleting")
    }
}

struct ButtonsAndAlerts_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsAndImages()
    }
}
