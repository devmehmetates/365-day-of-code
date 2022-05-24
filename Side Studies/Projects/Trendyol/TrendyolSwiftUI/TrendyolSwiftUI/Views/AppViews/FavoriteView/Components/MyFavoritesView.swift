//
//  MyFavoritesView.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 21.05.2022.
//

import SwiftUI
import CoreData

struct MyFavoritesView: View {
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFavorite == %@", NSNumber(value: true))) var favorites: FetchedResults<Product>
    
    var body: some View {
        List{
            ForEach(favorites, id: \.self){ product in
                NavigationLink {
                    Text("Deneme")
                } label: {
                    FavoriteCardView(product: product)
                }.listRowSeparator(.visible, edges: .bottom)
                    .buttonStyle(.plain)
                    
            }.onDelete { indexSet in
                
            }
            
        }.listStyle(.plain)
            .padding(.top, 25.0.responsiveW)
    }
}

struct MyFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoritesView()
    }
}
