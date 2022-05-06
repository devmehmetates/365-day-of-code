//
//  TabBarView.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 6.05.2022.
//

import SwiftUI

struct TabBarView: View {
    @Binding var currentTab : String
    
    var body: some View {
        HStack(spacing:0){
            TabBarButtonView(currentTab: self.$currentTab, title: "Anasayfa", image: "house")
            TabBarButtonView(currentTab: self.$currentTab, title: "Go", image: "speedometer")
            TabBarButtonView(currentTab: self.$currentTab, title: "Favorilerim", image: "heart")
            TabBarButtonView(currentTab: self.$currentTab, title: "Sepetim", image: "bag")
            TabBarButtonView(currentTab: self.$currentTab, title: "Hesabım", image: "person")
        }
    }
}
