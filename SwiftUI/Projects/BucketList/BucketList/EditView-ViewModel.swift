//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Mehmet Ateş on 6.06.2022.
//

import Foundation
import SwiftUI

extension EditView{
    @MainActor class EditViewModel: ObservableObject{
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()

        @Published var name: String = ""
        @Published var description: String = ""
        
        let imageHeight: CGFloat? = UIScreen.main.bounds.width * 0.4
        let imageWidth: CGFloat? = nil
        
        
        func setStateFields(name: String, description: String){
            self.name = name
            self.description = description
        }
        
        func fetchNearbyPlaces(location: MainLocation) async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                self.pages = items.query.pages.values.sorted()
                self.loadingState = .loaded
            } catch {
                self.loadingState = .failed
            }
        }
    }
}


