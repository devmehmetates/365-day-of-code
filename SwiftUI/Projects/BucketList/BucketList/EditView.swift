//
//  EditView.swift
//  BucketList
//
//  Created by Mehmet Ateş on 3.06.2022.
//

import SwiftUI

struct EditView: View {
    @StateObject private var _viewModel = EditViewModel()
    @Environment(\.dismiss) var dismiss

    var location: MainLocation
    var onSave: (MainLocation) -> Void
    
    init(location: MainLocation, onSave: @escaping (MainLocation) -> Void) {
        self.location = location
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $_viewModel.name)
                    TextField("Description", text: $_viewModel.description)
                }
                
                Section("Nearby…") {
                    switch _viewModel.loadingState {
                    case .loaded:
                        ForEach(_viewModel.pages, id: \.pageid) { page in
                            AsyncImage(url: URL(string: page.thumbnail?.source ?? ""), scale: 1, transaction: .init(animation: .easeInOut)) { phase in
                                if let loadedImage = phase.image{
                                    loadedImage
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: _viewModel.imageWidth, height: _viewModel.imageHeight, alignment: .center)
                                        .clipped()
                                        .cornerRadius(10)
                                }else if phase.error != nil{
                                    Image(systemName: "xmark")
                                        .frame(width: _viewModel.imageWidth, height: _viewModel.imageHeight, alignment: .center)
                                }else{
                                    ProgressView()
                                        .frame(width: _viewModel.imageWidth, height: _viewModel.imageHeight, alignment: .center)
                                }
                            }
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = _viewModel.name
                    newLocation.description = _viewModel.description

                    onSave(newLocation)
                    dismiss()
                }
            }.task {
                await _viewModel.fetchNearbyPlaces(location: location)
            }.onAppear{
                _viewModel.setStateFields(name: location.name, description: location.description)
            }
        }
    }
    

}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: MainLocation.example) { newLocation in }
    }
}
