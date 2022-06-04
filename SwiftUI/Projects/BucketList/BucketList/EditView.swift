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
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()

    @State private var name: String
    @State private var description: String
    var onSave: (MainLocation) -> Void
    
    init(location: MainLocation, onSave: @escaping (MainLocation) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    let imageHeight: CGFloat? = UIScreen.main.bounds.width * 0.4
    let imageWidth: CGFloat? = nil

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby…") {
                    switch loadingState {
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            AsyncImage(url: URL(string: page.thumbnail?.source ?? ""), scale: 1, transaction: .init(animation: .easeInOut)) { phase in
                                if let loadedImage = phase.image{
                                    loadedImage
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
                                        .clipped()
                                        .cornerRadius(10)
                                }else if phase.error != nil{
                                    Image(systemName: "xmark")
                                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
                                }else{
                                    ProgressView()
                                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
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
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation)
                    dismiss()
                }
            }.task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // we got some data back!
            let items = try JSONDecoder().decode(Result.self, from: data)

            // success – convert the array values to our pages array
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            // if we're still here it means the request failed somehow
            loadingState = .failed
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: MainLocation.example) { newLocation in }
    }
}
