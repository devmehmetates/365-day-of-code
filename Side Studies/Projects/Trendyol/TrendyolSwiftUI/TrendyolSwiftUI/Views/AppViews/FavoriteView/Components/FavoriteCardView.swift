//
//  FavoriteCardView.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 23.05.2022.
//

import SwiftUI

struct FavoriteCardView: View {
    var product: Product
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: product.imageURL!), scale: 1, transaction: .init(animation: .easeInOut)) { phase in
                if let loadedImage = phase.image{
                    loadedImage.resizable()
                        .frame(width: 30.0.responsiveW, height: 20.0.responsiveH, alignment: .center)
                        .scaledToFill()
                        .clipped()
                        .padding(.leading)
                }else if phase.error != nil{
                    Image(systemName: "xmark")
                        .resizable()
                }else {
                    ProgressView()
                }
            }.frame(width: 30.0.responsiveW, height: 20.0.responsiveH, alignment: .center)
            VStack(alignment: .leading){
                Text(product.brand ?? "Bilinmiyor")
                    .font(.headline)
                Text(product.desc ?? "Bilinmiyor")
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                HStack{
                    ReviewPointView()
                    Text("(31)")
                        .font(.footnote)
                }
                
                Spacer()
                
                VStack(alignment: .leading){
                    if product.discount{
                        Text("Sepette İndirimli")
                            .font(.footnote)
                            .foregroundColor(.accentColor)
                    }
                    Text("\(product.price.formatted()) TL")
                        .foregroundColor(.accentColor)
                        .font(.headline)
                }
                Spacer()
                
                HStack{
                    ZStack(alignment: .center){
                        Text("Tek Ebat")
                            .font(.footnote)
                        RoundedRectangle(cornerRadius: 5).stroke()
                    }.frame(width: 20.0.responsiveW, height: 10.0.responsiveW, alignment: .leading)
                        .foregroundColor(.gray.opacity(0.3))
                        
                    Button {
                        
                    } label: {
                        Text("Sepete Ekle")
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke())
                            .foregroundColor(.accentColor)
                    }.frame(width: 30.0.responsiveW, height: 10.0.responsiveW, alignment: .center)
                        .buttonStyle(.plain)
                }
                
                
            }.frame(width: 55.0.responsiveW, height: 25.0.responsiveH, alignment: .leading)
                .padding()
        }.frame(height: 30.0.responsiveH, alignment: .center)
    }
}

struct ReviewPointView: View{
    
    var body: some View{
        HStack{
            ForEach(0..<5, id: \.self){ _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.caption2)
            }
        }
    }
}
