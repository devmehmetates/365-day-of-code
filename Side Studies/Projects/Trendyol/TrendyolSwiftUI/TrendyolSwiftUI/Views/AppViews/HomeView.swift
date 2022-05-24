//
//  HomeView.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 6.05.2022.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject private var favoriteSystem = FavoriteViewModel()
    
    var body: some View {
        Button("Add Favorite"){
            favoriteSystem.saveFavorite(moc)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
