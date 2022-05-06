//
//  TabController.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 6.05.2022.
//

import SwiftUI

struct TabController: View {
    @State private var currentTab = "Anasayfa"
    var body: some View {
        TabView(selection: $currentTab){
            HomeView()
                .tag("Anasayfa")
            GoView()
                .tag("Go")
            FavoriteView()
                .tag("Favorilerim")
            BasketView()
                .tag("Sepetim")
            ProfileView()
                .tag("Hesabım")
        }.overlay(
            TabBarView(currentTab: $currentTab)
            ,alignment: .bottom
        )
    }
}

struct TabController_Previews: PreviewProvider {
    static var previews: some View {
        TabController()
    }
}
