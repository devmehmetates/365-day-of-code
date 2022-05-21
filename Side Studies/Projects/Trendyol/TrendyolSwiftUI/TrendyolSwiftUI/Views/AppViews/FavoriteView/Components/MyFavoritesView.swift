//
//  MyFavoritesView.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 21.05.2022.
//

import SwiftUI

struct MyFavoritesView: View {
    var body: some View {
        List{
            ForEach(0..<100, id: \.self){ number in
                NavigationLink {
                    Text("Deneme")
                } label: {
                    Text(number.formatted())
                        .frame(height: 30.0.responsiveW, alignment: .center)
                }.swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    VStack{
                        Button("Deneme"){
                            
                        }
                        Button("Deneme"){
                            
                        }
                    }
                }
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
