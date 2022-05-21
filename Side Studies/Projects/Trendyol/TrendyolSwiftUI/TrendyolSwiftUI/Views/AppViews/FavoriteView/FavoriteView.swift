//
//  FavoriteView.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 6.05.2022.
//

import SwiftUI

struct FavoriteView: View {
    @State private var currentTab = "Favorilerim"
    
    var body: some View {
        NavigationView{
            TabView(selection: $currentTab){
                MyFavoritesView()
                    .tag("Favorilerim")
                    .gesture(DragGesture())
                MyCollectionsView()
                    .tag("Koleksiyonlarım")
                    .gesture(DragGesture())
            }.overlay(
                TopTabBarView(currentTab: $currentTab)
                ,alignment: .top
            ).tabViewStyle(.page(indexDisplayMode: .never))
                .navigationBarHidden(true)
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
struct TopTabBarView: View {
    @State private var selectionOffset: CGFloat = -25.0.responsiveW
    @Binding var currentTab : String
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing:0){
                TopTabBarButtonView(selectionOffset: $selectionOffset, currentTab: self.$currentTab, title: "Favorilerim", image: "heart")
                Spacer()
                TopTabBarButtonView(selectionOffset: $selectionOffset, currentTab: self.$currentTab, title: "Koleksiyonlarım", image: "heart")
            }
            Rectangle()
                .frame(width: 50.0.responsiveW, height: 1.0.responsiveW, alignment: .center)
                .foregroundColor(.orange)
                .offset(x: selectionOffset)
            HStack{
               RoundedRectangle(cornerRadius: 10)
                    .frame(width:55.0.responsiveW, height: 10.0.responsiveW, alignment: .center)
                    .foregroundColor(.gray.opacity(0.2))
                Spacer()
                Button {
                    
                } label: {
                    HStack{
                        Image(systemName: "pencil")
                        Text("Düzenle")
                    }.frame(width:30.0.responsiveW, height: 10.0.responsiveW, alignment: .center)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke().foregroundColor(.gray.opacity(0.2)))
                }.foregroundColor(.primary)

            }.frame(height: 15.0.responsiveW, alignment: .center)
                .padding(.horizontal)
        }.frame(height: 25.0.responsiveW, alignment: .center)
            .onChange(of: currentTab) { newValue in
                withAnimation{
                    if currentTab == "Favorilerim"{
                        selectionOffset = -25.0.responsiveW
                    }else if currentTab == "Koleksiyonlarım"{
                        selectionOffset = 25.0.responsiveW
                    }
                }
            }
    }
}

struct TopTabBarButtonView: View {
    @Binding var selectionOffset: CGFloat
    @Binding var currentTab : String
    var title : String
    var image : String
    private var isSelected: Bool{
        return title == currentTab
    }
    
    var body: some View{
        Button{
            withAnimation{
                currentTab = title
            }
        }label: {
            Text(title)
                .foregroundColor(currentTab == title ? .orange : .secondary)
        }.frame(width: 50.0.responsiveW, height: 9.0.responsiveW, alignment: .center)
    }
}
