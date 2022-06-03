//
//  EditView.swift
//  BucketList
//
//  Created by Mehmet Ateş on 3.06.2022.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: MainLocation

    @State private var name: String
    @State private var description: String
    var onSave: (MainLocation) -> Void
    
    init(location: MainLocation, onSave: @escaping (MainLocation) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: MainLocation.example) { newLocation in }
    }
}
